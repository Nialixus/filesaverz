import 'dart:io';
import 'package:flutter/services.dart';

export '../addons/initiatedirectory.dart' hide methodChannel, initDir;

/// Connection flutter to native android.
const MethodChannel methodChannel = MethodChannel("filesaver");

/// If [initialDirectory] is null, in android is calling a [MethodChannel] of [Environment.getExternalStorageDirectory](https://developer.android.com/reference/android/os/Environment#getExternalStorageDirectory()).
///
/// In another platform, by default will use [Directory.systemTemp] and if it doen's exist, it will using [Directory.current].
Future<Directory> initDir(Directory? initialDirectory) async {
  if (initialDirectory == null) {
    try {
      String externalStoragePath =
          await methodChannel.invokeMethod("getDirectory");
      return Directory(externalStoragePath);
    } catch (e) {
      throw Exception(e);
    }
  } else {
    return initialDirectory;
  }
}
