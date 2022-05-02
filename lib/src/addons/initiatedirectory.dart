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
    try {
      String externalStoragePath =
          await methodChannel.invokeMethod("getDirectory");
      return Directory(externalStoragePath);
    } catch (e) {
      if (Directory.systemTemp.existsSync() == false) return Directory.current;

      return Directory.systemTemp;
    }
  }
  return initialDirectory;
}
