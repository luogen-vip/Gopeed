import 'dart:io';

import 'package:external_path/external_path.dart';
import 'package:path/path.dart' as path;
import 'package:permission_handler/permission_handler.dart';

/// Android 上优先使用公共 Download 目录；探测不到可写就返回 null 交给调用方回退。
Future<String?> androidDefaultDownloadDir() async {
  try {
    final downloads = await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOAD);
    if (downloads.isEmpty) return null;
    if (await _probe(downloads)) return downloads;
    // Android 11+ 写公共目录需要「所有文件访问」权限，申请一次再试。
    final status = await Permission.manageExternalStorage.status;
    if (!status.isGranted) {
      final requested = await Permission.manageExternalStorage.request();
      if (requested.isGranted && await _probe(downloads)) return downloads;
    }
    return null;
  } catch (_) {
    return null;
  }
}

Future<bool> _probe(String directory) async {
  final probe = File(path.join(directory, '.gopeed-write-test.tmp'));
  try {
    await probe.create(recursive: true);
    await probe.writeAsString('test', flush: true);
    await probe.delete();
    return true;
  } catch (_) {
    return false;
  }
}
