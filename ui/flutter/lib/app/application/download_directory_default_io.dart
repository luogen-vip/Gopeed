import 'dart:io';

import 'package:external_path/external_path.dart';
import 'package:path/path.dart' as path;

/// Android 上优先使用公共 Download 目录；探测不到可写就返回 null 交给调用方回退。
Future<String?> androidDefaultDownloadDir() async {
  try {
    final downloads = await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOAD);
    if (downloads.isEmpty) return null;
    final probe = File(path.join(downloads, '.gopeed-write-test.tmp'));
    await probe.create(recursive: true);
    await probe.writeAsString('test', flush: true);
    await probe.delete();
    return downloads;
  } catch (_) {
    return null;
  }
}
