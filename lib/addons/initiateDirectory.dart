import 'dart:io';

import 'package:flutter/services.dart';

MethodChannel methodChannel = const MethodChannel('initDir');

Future<String> initiateDirectory() async {
  if (Platform.isAndroid) {
    return await methodChannel.invokeMethod("getExternalStorageState");
  } else {
    return 'null';
  }
}
