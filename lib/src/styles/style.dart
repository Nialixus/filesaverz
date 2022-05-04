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
  /// Contains optionals [Color], [TextStyle] and [FileSaverIcon] which will be used on [FileSaver].
  ///
  /// if [icons] is null, will using [_fsIcons].\
  /// If [primaryColor] is null, will using [_fsPrimaryColor].\
  /// If [secondaryColor] is null, will using [_fsSecondaryColor].\
  /// If [primaryTextStyle] is null, will using [_fsPrimaryTextStyle].\
  /// If [secondaryTextStyle] is null, will using [_fsSecondaryTextStyle].
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

  /// An optional list of custom icon both for file and directory;
  ///
  /// ```dart
  /// List<FileSaverIcon> icons = const [
  ///    FileSaverIcon.directory(icon: (path) => Icon(Icons.directory)),
  ///    FileSaverIcon.file(fileType: 'jpg', icon: (path) => Icon(Icons.file)),
  /// ]
  /// ```S
  final List<FileSaverIcon>? icons;

  /// Customable displayed text in entire [FileSaver].
  final FileSaverText? text;
}
