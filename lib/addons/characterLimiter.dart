/// A function to limit [String] text length.
String characterLimiter(String string, int index) {
  return string.length >= index ? string.substring(0, index) : string;
}

/// A [String] extension to call [characterLimiter].
extension CharacterLimiter on String {
  /// A shortcut to limiting text length.
  ///
  /// ```dart
  /// String text = 'Hello World'.toLimit(5);
  /// print(text); // Hello
  /// ```
  String toLimit(int index) {
    return characterLimiter(this, index);
  }
}
