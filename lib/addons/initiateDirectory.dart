import 'dart:io';
import 'package:flutter/services.dart';

const MethodChannel methodChannel = MethodChannel("filesaver");

Future<Directory> initDir(Directory? initialDirectory) async {
  if (initialDirectory == null) {
    if (Platform.isAndroid) {
      return Directory(await methodChannel.invokeMethod("getDirectory"));
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
