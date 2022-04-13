String characterLimiter(String string, int index) {
  return string.length >= index ? string.substring(0, index) : string;
}

extension CharacterLimiter on String {
  String toLimit(int index) {
    return characterLimiter(this, index);
  }
}
