part of 'package:filesaverz/filesaverz.dart';

/// A custom style for [FileSaver].
class FileSaverStyle {
  /// Contains optional [Color], [TextStyle], [FileSaverIcon] and [FileSaverText].
  ///
  /// ```dart
  /// FileSaverStyle style = FileSaverStyle(
  ///   primaryColor: Colors.orange,
  ///   text: FileSaverText(
  ///     popupNo: 'Nay',
  ///     popupYes: 'Sí',
  ///   ),
  ///   icons: [
  ///     FileSaverIcon.file(
  ///       icon: (path) => Image.file(File(path)),
  ///       fileType: 'jpg',
  ///     )
  ///   ]
  /// );
  /// ```
  FileSaverStyle({
    this.text,
    this.icons = const [],
    this.primaryColor = Colors.blue,
    this.secondaryColor = Colors.white,
    this.primaryTextStyle = const TextStyle(
        color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
    this.secondaryTextStyle =
        const TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
  }) {
    text ?? FileSaverText();
  }

  /// An optional [Color]. Default value is [Colors.blue].
  final Color primaryColor;

  /// An optional [Color]. Mostly uses as background color.
  ///
  /// Default value is [Colors.white].
  final Color secondaryColor;

  /// An optional [TextStyle]. Mostly uses as header text style.
  ///
  /// Default value is :
  /// ```dart
  /// TextStyle primaryTextStyle = const TextStyle(
  ///   color: Colors.white,
  ///   fontSize: 20,
  ///   fontWeight: FontWeight.w600,
  /// );
  /// ```
  final TextStyle primaryTextStyle;

  /// An optional [TextStyle]. Mostly uses as list of [FileSystemEntity]'s name text style.
  ///
  /// Default value is :
  /// ```dart
  /// TextStyle secondaryTextStyle = const TextStyle(
  ///   color: Colors.black87,
  ///   fontWeight: FontWeight.bold,
  /// );
  /// ```
  final TextStyle secondaryTextStyle;

  /// An optional list of custom icon both for file and directory.
  ///
  /// ```dart
  /// List<FileSaverIcon> icons = const [
  ///    FileSaverIcon.directory(icon: (path) => Icon(Icons.directory)),
  ///    FileSaverIcon.file(fileType: 'jpg', icon: (path) => Icon(Icons.file)),
  /// ]
  /// ```
  final List<FileSaverIcon> icons;

  /// Customable displayed text in entire [FileSaver].
  ///
  /// ```dart
  /// FileSaverText(
  ///     popupNo: 'Nay',
  ///     popupYes: 'Sí',
  /// ),
  /// ```
  final FileSaverText? text;
}
