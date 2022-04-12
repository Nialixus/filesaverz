import 'dart:math';

String bytesConverter(int bytes) {
  const types = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
  int length = bytes.toString().length;

  if (length < 4) {
    String prefix =
        '$bytes'.contains('.') ? '$bytes'.split('.').first : '$bytes';
    String suffix =
        '$bytes'.contains('.') ? '.' + '$bytes'.split('.').last : '';
    return '$prefix${suffix.length >= 3 ? suffix.substring(0, 3) : suffix} ${types[0]}';
  } else {
    int index = length ~/ 4;
    String value = '${bytes / pow(1024, index)}';
    String prefix = value.contains('.') ? value.split('.').first : '$bytes';
    String suffix = value.contains('.') ? '.' + value.split('.').last : '';
    return '$prefix${suffix.length >= 3 ? suffix.substring(0, 3) : suffix} ${types[index]}';
  }
}

extension BytesConverter on int {
  String convertBytes() {
    return bytesConverter(this);
  }
}
