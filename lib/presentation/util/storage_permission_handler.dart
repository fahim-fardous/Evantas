import 'dart:io';

import 'package:evntas/presentation/util/file_downloader.dart';
import 'package:permission_handler/permission_handler.dart';

class StoragePermissionHandler {
  static Future<bool> requestStoragePermission() async {
    if (Platform.isAndroid && await FileDownloader.isAndroid10OrHigher()) {
      return _requestManageExternalStoragePermission();
    }
    return _requestBasicStoragePermission();
  }

  static Future<bool> _requestBasicStoragePermission() async {
    var status = await Permission.storage.status;

    if (status.isGranted) return true;

    if (status.isDenied) {
      status = await Permission.storage.request();
      if (status.isGranted) return true;
    }

    if (status.isPermanentlyDenied) {
      final openedSettings = await openAppSettings();
      if (!openedSettings) {
        throw Exception("Could not open app settings");
      }
      return false;
    }

    return false;
  }

  static Future<bool> _requestManageExternalStoragePermission() async {
    var status = await Permission.manageExternalStorage.status;

    if (status.isGranted) return true;

    if (status.isDenied) {
      status = await Permission.manageExternalStorage.request();
      if (status.isGranted) return true;
    }

    if (status.isPermanentlyDenied) {
      final openedSettings = await openAppSettings();
      if (!openedSettings) {
        throw Exception("Could not open app settings");
      }
      return false;
    }

    return false;
  }
}