import 'package:flutter/material.dart';

const Color fsPrimaryColor = Colors.blue;
const Color fsSecondaryColor = Colors.white;
const TextStyle fsPrimaryTextStyle =
    TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600);
const TextStyle fsSecondaryTextStyle =
    TextStyle(color: Colors.black87, fontWeight: FontWeight.bold);

class FileSaverStyle {
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
