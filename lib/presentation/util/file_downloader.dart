import 'dart:io';
import 'package:domain/util/logger.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';

class FileDownloader {
  static Future<String> getPublicFolderPath() async {
    try {
      if (Platform.isAndroid) {
        if (await isAndroid10OrHigher()) {
          final directory = await getExternalStorageDirectory();
          if (directory != null) {
            const downloadPath = '/storage/emulated/0/Download';
            Logger.debug("Android path: $downloadPath");

            await Directory(downloadPath).create(recursive: true);
            return downloadPath;
          }
        }

        const fallbackPath = "/storage/emulated/0/Download";
        final downloadDir = Directory(fallbackPath);
        if (!await downloadDir.exists()) {
          await downloadDir.create(recursive: true);
        }

        return fallbackPath;
      } else if (Platform.isIOS) {
        final directory = await getApplicationDocumentsDirectory();
        final downloadPath = '${directory.path}/Download';

        await Directory(downloadPath).create(recursive: true);
        return downloadPath;
      } else {
        throw Exception("Unsupported platform");
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<bool> isAndroid10OrHigher() async {
    if (Platform.isAndroid) {
      final sdkInt = await _getAndroidSdkVersion();
      return sdkInt >= 29;
    }
    return false;
  }

  static Future<int> _getAndroidSdkVersion() async {
    return 29;
  }

  static Future<File> writeFile(String name, List<int> data) async {
    try {
      Fluttertoast.showToast(
        msg: "Download started...",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );

      final path = await getPublicFolderPath();
      final file = File('$path/$name');

      final parent = file.parent;
      if (!await parent.exists()) {
        await parent.create(recursive: true);
      }

      final savedFile = await file.writeAsBytes(
        data,
        mode: FileMode.write,
        flush: true,
      );

      Fluttertoast.showToast(
        msg: "Download complete!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );

      return savedFile;
    } catch (e) {
      rethrow;
    }
  }
}


