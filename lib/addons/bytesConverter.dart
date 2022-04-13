import 'dart:math' show pow;
import '../addons/characterLimiter.dart';

String bytesConverter(int bytes) {
  List<String> types = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
  int length = bytes.toString().length;

  if (length < 4) {
    return '$bytes ${types[0]}';
  } else {
    int index = length ~/ 3;
    String value = '${bytes / pow(1024, index)}';
    String prefix = value.contains('.') ? value.split('.').first : '$bytes';
    String suffix = value.contains('.') ? '.' + value.split('.').last : '';
    return '$prefix${suffix.toLimit(3)} ${types[index]}';
  }
}

extension BytesConverter on int {
  String convertToBytes() {
    return bytesConverter(this);
  }
}
