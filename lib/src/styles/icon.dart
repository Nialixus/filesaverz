part of 'package:filesaverz/filesaverz.dart';

/// Customable icon for [FileSaver].
///
/// ```dart
/// FileSaverIcon(icon: (path) => Icon(Icons.file));
/// ```
class FileSaverIcon {
  /// Set which file extension whose icon will be changed.
  ///
  /// ```dart
  /// String fileType = 'jpg',
  /// ```
  final String fileType;

  /// Set new custom icon by using any widget.
  ///
  /// ```dart
  /// icon: (path) => Image.file(File(path)),
  /// ```
  final Widget Function(String path) icon;

  /// To detect which type of icon will be changed.
  final Type type;

  /// Set default icon for every [fileType].
  ///
  /// ```dart
  /// FileSaverIcon(
  ///   icon: (path) => Icon(Icons.file),
  /// );
  /// ```
  const FileSaverIcon({required this.icon})
      : type = File,
        fileType = 'filesavericon.default';

  /// Set icon for certain [fileType].
  ///
  /// ```dart
  /// FileSaverIcon.file(
  ///   icon: (path) => Image.file(File(path)),
  ///   fileType: 'jpg',
  /// );
  /// ```
  const FileSaverIcon.file({required this.fileType, required this.icon})
      : type = File;

  /// Set icon for directory.
  ///
  /// ```dart
  /// FileSaverIcon.directory(
  ///   icon: (path) => Icon(Icons.directory),
  /// );
  /// ```
  const FileSaverIcon.directory({required this.icon})
      : type = Directory,
        fileType = '';
}
