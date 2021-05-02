import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

Future<bool> checkPermissions(List<Permission> permissions) async {
  bool granted = true;
  (await permissions.request()).forEach((key, value) {
    if (!value.isGranted) {
      granted = false;
    }
  });
  return granted;
}

Future<String> findLocalPath({bool forDownload = false}) async {
  final directory = Platform.isAndroid
      ? forDownload
          ? Directory('/storage/emulated/0/Download')
          : await getExternalStorageDirectory()
      : await getApplicationDocumentsDirectory();
  return directory.path;
}
