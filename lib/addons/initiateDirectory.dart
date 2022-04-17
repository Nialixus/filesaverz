import 'dart:io';
import 'package:flutter/services.dart';

const MethodChannel methodChannel = MethodChannel("filesaver");

Future<Directory> initDir(Directory? initialDirectory) async {
  if (initialDirectory == null) {
    if (Platform.isAndroid) {
      final String path = await methodChannel.invokeMethod("getDirectory");
      return Directory(path);
    } else {
      if (Directory.systemTemp.existsSync() == false) {
        return Directory.current;
      } else {
        return Directory.systemTemp;
      }
    }
  } else {
    return initialDirectory;
  }
}
