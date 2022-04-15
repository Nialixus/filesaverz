import 'dart:io';

import 'package:flutter/services.dart';

MethodChannel methodChannel = const MethodChannel("filesaver");

Future<String?> initDir() async {
  if (!Platform.isAndroid) throw UnsupportedError("Only Works in Android");
  return await methodChannel.invokeMethod("getDirectory");
}
