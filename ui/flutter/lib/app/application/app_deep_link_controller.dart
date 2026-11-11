import 'dart:async';
import 'dart:convert';

import 'package:app_links/app_links.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:share_handler/share_handler.dart';
import 'package:window_manager/window_manager.dart';

import '../../api/model/create_task.dart';
import '../../api/model/install_extension.dart';
import '../../api/model/request.dart';
import '../../core/entry/app_startup_options.dart';
import '../../core/utils/content_uri_resolver.dart';
import '../../features/extensions/application/pending_extension_install.dart';
import '../../util/util.dart';
import '../router/app_router.dart';
import 'app_runtime_controller.dart';

final appDeepLinkControllerProvider = AsyncNotifierProvider<AppDeepLinkController, AppDeepLinkState>(
  AppDeepLinkController.new,
);

class AppDeepLinkState {
  const AppDeepLinkState({this.started = false});

  final bool started;
}

class AppDeepLinkController extends AsyncNotifier<AppDeepLinkState> {
  StreamSubscription<Uri>? _subscription;
  StreamSubscription<SharedMedia>? _sharedMediaSubscription;
  bool _started = false;

  @override
  Future<AppDeepLinkState> build() async {
    if (_started || kIsWeb) {
      return AppDeepLinkState(started: _started);
    }
    // Deep-link handling depends on the runtime being ready, but it must not
    // rebuild whenever runtime settings change. A rebuild disposes the active
    // platform subscriptions while `_started` remains true, leaving Android
    // unable to receive later browser takeover intents (for example after the
    // API server is started or stopped from Settings).
    await ref.read(appRuntimeControllerProvider.future);
    _started = true;
    final appLinks = AppLinks();
    _subscription = appLinks.uriLinkStream.listen((uri) {
      unawaited(_handleUri(uri).catchError((Object error, StackTrace stack) {
        debugPrint('Unable to handle deep link $uri: $error');
      }));
    });
    if (Util.isMobile()) {
      final shareHandler = ShareHandlerPlatform.instance;
      _sharedMediaSubscription = shareHandler.sharedMediaStream.listen((media) {
        unawaited(_handleSharedMedia(media, ignoreContentUri: true));
      });
      try {
        final media = await shareHandler.getInitialSharedMedia();
        if (media != null) {
          await _handleSharedMedia(media);
        }
      } catch (_) {}
    }
    ref.onDispose(() {
      _subscription?.cancel();
      _sharedMediaSubscription?.cancel();
    });
    try {
      final initial = await appLinks.getInitialLink();
      if (initial != null) {
        await _handleUri(initial);
      }
    } catch (error) {
      debugPrint('Unable to read initial link: $error');
    }
    return const AppDeepLinkState(started: true);
  }

  Future<void> _handleSharedMedia(SharedMedia media, {bool ignoreContentUri = false}) async {
    final uri = sharedMediaUri(media);
    if (uri == null || (ignoreContentUri && uri.scheme == 'content')) return;
    await _handleUri(uri);
  }

  Future<void> _handleUri(Uri uri) async {
    final normalized = normalizeExternalUri(uri);
    if (normalized == null) return;
    if (normalized.scheme == 'gopeed') {
      await _handleGopeedUri(normalized);
      return;
    }
    final createTask = CreateTask(req: Request(url: await _uriToTaskUrl(normalized)));
    await _openCreate(createTask);
  }

  Future<void> _handleGopeedUri(Uri uri) async {
    if (isSilentGopeedWakeUri(uri)) {
      return;
    }
    final route = gopeedDeepLinkRoute(uri);
    if (route == '/create') {
      final params = uri.queryParameters['params'];
      if (params?.isNotEmpty == true) {
        await _openCreate(CreateTask.fromJson(_decodeParams(params!)));
        return;
      }
      await _openCreate(null);
      return;
    }

    if (route == '/extension') {
      final params = uri.queryParameters['params'];
      if (params?.isNotEmpty == true) {
        ref.read(pendingExtensionInstallProvider.notifier).set(InstallExtension.fromJson(_decodeParams(params!)));
      }
      await _go('/extensions');
      return;
    }

    await _go('/');
  }

  Future<void> _openCreate(CreateTask? createTask) => AppRouter.openCreateTask(createTask: createTask);

  Future<void> _go(String route) async {
    if (Util.isDesktop()) {
      await windowManager.show();
      await windowManager.focus();
    }
    final context = AppRouter.rootNavigatorKey.currentContext;
    if (context != null && context.mounted) {
      context.go(route);
    }
  }

  Map<String, dynamic> _decodeParams(String params) {
    final safeParams = params.replaceAll('"', '').replaceAll(' ', '+');
    final paramsJson = utf8.decode(base64Decode(base64.normalize(safeParams)));
    return jsonDecode(paramsJson) as Map<String, dynamic>;
  }

  Future<String> _uriToTaskUrl(Uri uri) async {
    if (uri.scheme == 'magnet' || uri.scheme == 'http' || uri.scheme == 'https') {
      return uri.toString();
    }
    if (uri.scheme == 'file') {
      return Util.isWindows() ? Uri.decodeFull(uri.path.substring(1)) : uri.path;
    }
    if (uri.scheme == 'content' && Util.isAndroid()) {
      return ContentUriResolver.copyToCache(uri);
    }
    throw ArgumentError.value(uri, 'uri', 'Unsupported task URI scheme');
  }
}

/// Accepts the loose links some apps deliver (missing scheme, surrounding
/// whitespace, trailing punctuation) and rejects anything that is not a real
/// download target, so the create page is never opened with an empty URL.
Uri? normalizeExternalUri(Uri uri) {
  final raw = uri.toString().trim();
  if (raw.isEmpty) return null;
  if (uri.scheme.isEmpty) {
    final match = RegExp(r'^(?:www\.)?[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)+(?:[/?#].*)?$').firstMatch(raw);
    if (match == null) return null;
    return Uri.tryParse('https://$raw');
  }
  const supported = {'http', 'https', 'gopeed', 'magnet', 'file', 'content', 'ftp', 'ftps', 'ftpes', 'ed2k'};
  if (!supported.contains(uri.scheme.toLowerCase())) return null;
  return uri;
}

/// Picks the actionable URI from content received through the platform share UI.
///
/// File attachments take precedence over an optional text caption. Both the
/// Android and iOS share-handler implementations expose attachments as local
/// paths that are ready for the app to read.
Uri? sharedMediaUri(SharedMedia media) {
  final attachments = media.attachments;
  if (attachments != null) {
    for (final attachment in attachments) {
      final path = attachment?.path.trim();
      if (path != null && path.isNotEmpty) return Uri.file(path);
    }
  }

  final content = media.content?.trim();
  if (content == null || content.isEmpty) return null;
  return extractSharedUri(content);
}

/// Browsers and other apps often share a whole sentence ("看看这个 https://…")
/// together with the link, and plain `Uri.tryParse` then rejects the payload,
/// which previously ended up as an empty task and a failed download.
Uri? extractSharedUri(String raw) {
  final text = raw.trim();
  if (text.isEmpty) return null;
  const schemes = {'http', 'https', 'gopeed', 'magnet', 'file', 'content', 'ftp', 'ftps', 'ftpes', 'ed2k'};
  final direct = Uri.tryParse(text);
  if (direct != null && schemes.contains(direct.scheme.toLowerCase())) {
    return direct;
  }
  final match = RegExp(r'(https?://[^\s<>"”"]+|magnet:\?[^\s<>"”"]+|ftp[se]?://[^\s<>"”"]+)').firstMatch(text);
  if (match == null) return null;
  final candidate = match.group(0)!.replaceFirst(RegExp(r'[),.;]+$'), '');
  return Uri.tryParse(candidate);
}

/// Gopeed's established links use `gopeed:///create`, where the action is the
/// URI path. Do not interpret the URI host as an action: the host-style
/// `gopeed://create` form is intentionally unsupported.
String gopeedDeepLinkRoute(Uri uri) {
  return uri.path;
}
