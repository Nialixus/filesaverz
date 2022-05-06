part of 'package:filesaverz/filesaverz.dart';

/// A successful message.
void _successMessage(BuildContext context, [FileSaverStyle? style]) {
  FileSaverStyle defaultStyle = style ?? const FileSaverStyle();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        defaultStyle.text!.messageSucces!,
        style: defaultStyle.primaryTextStyle?.copyWith(
            fontSize: defaultStyle.secondaryTextStyle?.fontSize ?? 14),
      ),
      backgroundColor: defaultStyle.primaryColor,
    ),
  );
}

/// A group of extensions for [FileSaver].
extension FileSaverExtension on FileSaver {
  /// Picking a [File].
  ///
  /// ```dart
  /// FileSaver fileSaver = FileSaver(
  ///   initialFileName:'File Name',
  ///   fileTypes: const ['txt'],
  /// );
  ///
  /// File? file = await fileSaver.pickFile(context);
  /// ```
  Future<File?> pickFile(BuildContext context) async {
    String? path = await filebrowser(
        context,
        FileSaver._picker(
          style: style,
          multiPicker: false,
          fileTypes: fileTypes,
          bodyBuilder: bodyBuilder,
          footerBuilder: footerBuilder,
          headerBuilder: headerBuilder,
          initialFileName: initialFileName,
          initialDirectory: initialDirectory,
        ));
    if (path != null) {
      return File(path);
    } else {
      return null;
    }
  }

  /// Picking list of [File].
  ///
  /// ```dart
  /// FileSaver fileSaver = FileSaver(
  ///   initialFileName:'File Name',
  ///   fileTypes: const ['txt'],
  /// );
  ///
  /// List<File>? files = await fileSaver.pickFiles(context);
  /// ```
  Future<List<File>?> pickFiles(BuildContext context) async {
    String? path = await filebrowser(
        context,
        FileSaver._picker(
          style: style,
          multiPicker: true,
          fileTypes: fileTypes,
          bodyBuilder: bodyBuilder,
          footerBuilder: footerBuilder,
          headerBuilder: headerBuilder,
          initialFileName: initialFileName,
          initialDirectory: initialDirectory,
        ));
    if (path != null) {
      List<String> paths =
          path.replaceAll('[', '').replaceAll(']', '').split(',');
      return List.generate(paths.length, (x) => File(paths[x]));
    } else {
      return null;
    }
  }

  /// Returning path from saved file.
  ///
  /// ```dart
  /// FileSaver fileSaver = FileSaver(
  ///   initialFileName:'File Name',
  ///   fileTypes: const ['txt'],
  /// );
  ///
  /// String? path = await fileSaver.getPath(context);
  /// print(path); // storage/emulated/0/File Name.txt
  /// ```
  Future<String?> getPath(BuildContext context) => filebrowser(context, this);

  /// Calling [writeAsBytes](https://api.flutter.dev/flutter/dart-io/File/writeAsBytes.html) method.
  ///
  /// ```dart
  /// FileSaver fileSaver = FileSaver(
  ///   initialFileName:'File Name',
  ///   fileTypes: const ['txt'],
  /// );
  ///
  /// fileSaver.writeAsBytes(bytes, context:context);
  /// ```
  Future<File?> writeAsBytes(List<int> bytes,
      {required BuildContext context,
      mode = FileMode.write,
      bool flush = false}) async {
    String? path = await filebrowser(context, this);
    if (path != null) {
      _successMessage(context, style);
      if (File(path).existsSync()) {
        return File(path)
            .writeAsBytes(bytes, mode: FileMode.write, flush: flush);
      } else {
        return File(path).writeAsBytes(bytes, mode: mode, flush: flush);
      }
    } else {
      return null;
    }
  }

  /// Calling [writeAsBytesSync](https://api.flutter.dev/flutter/dart-io/File/writeAsBytesSync.html) method.
  ///
  /// ```dart
  /// FileSaver fileSaver = FileSaver(
  ///   initialFileName:'File Name',
  ///   fileTypes: const ['txt'],
  /// );
  ///
  /// fileSaver.writeAsBytesSync(bytes, context:context);
  /// ```
  void writeAsBytesSync(List<int> bytes,
      {required BuildContext context,
      mode = FileMode.write,
      bool flush = false}) async {
    String? path = await filebrowser(context, this);
    if (path != null) {
      _successMessage(context, style);
      if (File(path).existsSync()) {
        File(path).writeAsBytesSync(
          bytes,
          mode: FileMode.write,
          flush: flush,
        );
      } else {
        File(path).writeAsBytesSync(
          bytes,
          mode: mode,
          flush: flush,
        );
      }
    }
  }

  /// Calling [writeAsString](https://api.flutter.dev/flutter/dart-io/File/writeAsString.html) method.
  ///
  /// ```dart
  /// FileSaver fileSaver = FileSaver(
  ///   initialFileName:'File Name',
  ///   fileTypes: const ['txt'],
  /// );
  ///
  /// fileSaver.writeAsString(bytes, context:context);
  /// ```
  Future<File?> writeAsString(String contents,
      {required BuildContext context,
      mode = FileMode.write,
      Encoding encoding = utf8,
      bool flush = false}) async {
    String? path = await filebrowser(context, this);
    if (path != null) {
      _successMessage(context, style);
      if (File(path).existsSync()) {
        return File(path).writeAsString(
          contents,
          mode: FileMode.write,
          encoding: encoding,
          flush: flush,
        );
      } else {
        return File(path).writeAsString(
          contents,
          mode: mode,
          encoding: encoding,
          flush: flush,
        );
      }
    } else {
      return null;
    }
  }

  /// Calling [writeAsStringSync](https://api.flutter.dev/flutter/dart-io/File/writeAsStringSync.html) method.
  ///
  /// ```dart
  /// FileSaver fileSaver = FileSaver(
  ///   initialFileName:'File Name',
  ///   fileTypes: const ['txt'],
  /// );
  ///
  /// fileSaver.writeAsStringSync(bytes, context:context);
  /// ```
  void writeAsStringSync(String contents,
      {required BuildContext context,
      mode = FileMode.write,
      Encoding encoding = utf8,
      bool flush = false}) async {
    String? path = await filebrowser(context, this);
    if (path != null) {
      _successMessage(context, style);
      if (File(path).existsSync()) {
        File(path).writeAsStringSync(
          contents,
          mode: FileMode.write,
          encoding: encoding,
          flush: flush,
        );
      } else {
        File(path).writeAsStringSync(
          contents,
          mode: mode,
          encoding: encoding,
          flush: flush,
        );
      }
    }
  }
}
