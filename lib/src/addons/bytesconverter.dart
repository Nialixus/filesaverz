import 'dart:math';
import 'characterlimiter.dart';

export '../addons/bytesconverter.dart' hide bytesConverter, BytesConverter;

///A function for converting [int] to structured [String].
String bytesConverter(int bytes) {
  /// List of suffixes.
  List<String> types = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];

  /// Length of characters.
  int length = bytes.toString().length;

  if (length < 4) {
    return '$bytes ${types[0]}';
  } else {
    int index = length ~/ 3;
    String value = '${bytes / pow(1024, index)}';
    String prefix = value.contains('.') ? value.split('.').first : '$bytes';
    String suffix = value.contains('.') ? '.${value.split('.').last}' : '';
    return '$prefix${suffix.toLimit(3)} ${types[index]}';
  }
}

/// An [int] extension to call [bytesConverter].
extension BytesConverter on int {
  ///Returning a structured [String] by calling [bytesConverter].
  ///
  /// ```dart
  /// int number = 1000;
  /// String result = number.convertToBytes();
  /// print(result); // 0.97 KB
  ///
  /// ```
  String convertToBytes() {
    return bytesConverter(this);
  }
}
