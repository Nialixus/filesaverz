part of 'package:filesaverz/filesaverz.dart';

/// Primary [Color] of [FileSaver].
const Color _fsPrimaryColor = Colors.blue;

/// Secondary [Color] of [FileSaver]. Mostly used as background color.
const Color _fsSecondaryColor = Colors.white;

/// Primary [TextStyle] of [FileSaver]. Mostly used in front of primary Color.
const TextStyle _fsPrimaryTextStyle =
    TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600);

/// Secondary [TextStyle] of [FileSaver]. Mostyly used in front of secondary color.
const TextStyle _fsSecondaryTextStyle =
    TextStyle(color: Colors.black87, fontWeight: FontWeight.bold);

/// Default icons for [FileSaverStyle].
const List<FileSaverIcon> _fsIcons = [];

/// Default text for [FileSaverStyle].
const FileSaverText _fsText = FileSaverText();

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
  const FileSaverStyle({
    this.text = _fsText,
    this.icons = _fsIcons,
    this.primaryColor = _fsPrimaryColor,
    this.secondaryColor = _fsSecondaryColor,
    this.primaryTextStyle = _fsPrimaryTextStyle,
    this.secondaryTextStyle = _fsSecondaryTextStyle,
  });

  /// An optional [Color]. Default value is [_fsPrimaryColor].
  final Color? primaryColor;

  /// An optional [Color]. Mostly uses as background color.
  ///
  /// Default value is [_fsSecondaryColor].
  final Color? secondaryColor;

  /// An optional [TextStyle]. Mostly uses as header text style.
  ///
  /// Default value is [_fsPrimaryTextStyle].
  final TextStyle? primaryTextStyle;

  /// An optional [TextStyle]. Mostly uses as list of [FileSystemEntity]'s name text style.
  ///
  /// Default value is [_fsSecondaryTextStyle].
  final TextStyle? secondaryTextStyle;

  /// An optional list of custom icon both for file and directory.
  ///
  /// ```dart
  /// List<FileSaverIcon> icons = const [
  ///    FileSaverIcon.directory(icon: (path) => Icon(Icons.directory)),
  ///    FileSaverIcon.file(fileType: 'jpg', icon: (path) => Icon(Icons.file)),
  /// ]
  /// ```
  final List<FileSaverIcon>? icons;

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
