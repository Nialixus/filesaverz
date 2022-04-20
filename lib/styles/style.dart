part of 'package:filesaver/filesaver.dart';

/// Primary [Color] of [FileSaver].
const Color fsPrimaryColor = Colors.blue;

/// Secondary [Color] of [FileSaver]. Mostly used as background color.
const Color fsSecondaryColor = Colors.white;

/// Primary [TextStyle] of [FileSaver]. Mostly used in front of primary Color.
const TextStyle fsPrimaryTextStyle =
    TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600);

/// Secondary [TextStyle] of [FileSaver]. Mostyly used in front of secondary color.
const TextStyle fsSecondaryTextStyle =
    TextStyle(color: Colors.black87, fontWeight: FontWeight.bold);

/// A custom style for [FileSaver].
class FileSaverStyle {
  /// Contains optionals [Color] and [TextStyle] which will be used on [FileSaver].
  ///
  /// If [primaryColor] is null, will using [fsPrimaryColor].\
  /// If [secondaryColor] is null, will using [fsSecondaryColor].\
  /// If [primaryTextStyle] is null, will using [fsPrimaryTextStyle].\
  /// If [secondaryTextStyle] is null, will using [fsSecondaryTextStyle].
  FileSaverStyle(
      {Color? primaryColor,
      Color? secondaryColor,
      TextStyle? primaryTextStyle,
      TextStyle? secondaryTextStyle})
      : primaryColor = primaryColor ?? fsPrimaryColor,
        secondaryColor = secondaryColor ?? fsSecondaryColor,
        primaryTextStyle = primaryTextStyle ?? fsPrimaryTextStyle,
        secondaryTextStyle = secondaryTextStyle ?? fsSecondaryTextStyle;

  /// An optional [Color]. Default value is [fsPrimaryColor].
  final Color? primaryColor;

  /// An optional [Color]. Mostly uses as background color.
  ///
  /// Default value is [fsSecondaryColor].
  final Color? secondaryColor;

  /// An optional [TextStyle]. Mostly uses as header text style.
  ///
  /// Default value is [fsPrimaryTextStyle].
  final TextStyle? primaryTextStyle;

  /// An optional [TextStyle]. Mostly uses as list of [FileSystemEntity]'s name text style.
  ///
  /// Default value is [fsPrimaryTextStyle].
  final TextStyle? secondaryTextStyle;
}
