export '../addons/datesconverter.dart' hide datesConverter, DatesConverter;

///A function for converting [DateTime] to structured [String].
String datesConverter(DateTime dateTime) {
  ///List name of months
  const List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'November',
    'December'
  ];

  return '${dateTime.day} ${months[dateTime.month - 1]} ${dateTime.year}';
}

///A datetime extension to call [datesConverter].
extension DatesConverter on DateTime {
  ///Returning a structured [String] by calling [datesConverter].
  ///
  ///```dart
  ///Datetime dateTime = DateTime(1970, 1, 1);
  ///String result = dateTime.datesConverter();
  ///print(result); // 1 January 1970
  ///```
  String convertToDates() {
    return datesConverter(this);
  }
}
