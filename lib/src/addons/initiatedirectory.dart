import 'dart:io';
import 'package:flutter/services.dart';

export '../addons/initiatedirectory.dart' hide methodChannel, initDir;

/// Uses to call `Environment.getExternalDirectory()` function in android.
const MethodChannel methodChannel = MethodChannel("filesaver");

/// If [initialDirectory] is null, in android it will getting external storage directory.
///
/// In another platform, by default will use [Directory.systemTemp] and if it doen's exist, it will using [Directory.current].
Future<Directory> initDir(Directory? initialDirectory) async {
  if (initialDirectory == null) {
    if (Platform.isAndroid) {
      String? externalStoragePath =
          await methodChannel.invokeMethod("getDirectory");
      if (externalStoragePath != null) {
        return Directory(externalStoragePath);
      } else if (Directory.systemTemp.existsSync() == false) {
        return Directory.current;
      } else {
        return Directory.systemTemp;
      }
    } else if (Directory.systemTemp.existsSync() == false) {
      return Directory.current;
    } else {
      return Directory.systemTemp;
    }
  } else {
    return initialDirectory;
  }
}
