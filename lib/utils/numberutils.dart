class NumberUtils {
  static addNumber(a, b) {
    int aInt = (a * 100).floor();
    int bInt = (b * 100).floor();
    return (aInt + bInt) / 100;
  }
}