part of 'package:filesaverz/filesaver.dart';

_successMessage(BuildContext context) =>
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('File has been saved'),
        backgroundColor: _fsPrimaryColor,
      ),
    );

/// A group of extensions for [FileSaver.picker].
extension FilePickerExtension on FilePicker {
  /// Returning path from choosen [Directory] combined with file name and file type.
  ///
  /// ```dart
  /// FileSaver fileSaver = FileSaver(
  ///   initialFileName:'File Name',
  ///   fileTypes: const['.txt'],
  /// );
  ///
  /// String? path = await fileSaver.getPath(context);
  /// print(path); // storage/emulated/0/File Name.txt
  /// ```
  Future<File?> getFile(BuildContext context) async {
    String? path = await filebrowser(context, filePicker: this);
    if (path != null) {
      return File(path);
    }
    return null;
  }

  Future<List<File>?> getFiles(BuildContext context) async {
    String? path = await filebrowser(context,
        filePicker: copyWith(
          multiPicker: true,
        ));
    if (path != null) {
      List<String> paths =
          path.replaceAll('[', '').replaceAll(']', '').split(',');
      return List.generate(paths.length, (x) => File(paths[x]));
    }
    return null;
  }
}

/// A group of extensions for [FileSaver].
extension FileSaverExtension on FileSaver {
  /// Returning path from choosen [Directory] combined with file name and file type.
  ///
  /// ```dart
  /// FileSaver fileSaver = FileSaver(
  ///   initialFileName:'File Name',
  ///   fileTypes: const['.txt'],
  /// );
  ///
  /// String? path = await fileSaver.getPath(context);
  /// print(path); // storage/emulated/0/File Name.txt
  /// ```
  Future<String?> getPath(BuildContext context) =>
      filebrowser(context, fileSaver: this);

  /// Calling [writeAsBytes](https://api.flutter.dev/flutter/dart-io/File/writeAsBytes.html) method.
  ///
  /// ```dart
  /// FileSaver fileSaver = FileSaver(
  ///   initialFileName:'File Name',
  ///   fileTypes: const['.txt'],
  /// );
  ///
  /// fileSaver.writeAsBytes(bytes, context:context);
  /// ```
  Future<File?> writeAsBytes(List<int> bytes,
      {required BuildContext context,
      mode = FileMode.write,
      bool flush = false}) async {
    String? path = await filebrowser(context, fileSaver: this);
    if (path != null) {
      _successMessage(context);
      if (File(path).existsSync()) {
        return File(path)
            .writeAsBytes(bytes, mode: FileMode.write, flush: flush);
      }

      return File(path).writeAsBytes(bytes, mode: mode, flush: flush);
    }
    return null;
  }

  /// Calling [writeAsBytesSync](https://api.flutter.dev/flutter/dart-io/File/writeAsBytesSync.html) method.
  ///
  /// ```dart
  /// FileSaver fileSaver = FileSaver(
  ///   initialFileName:'File Name',
  ///   fileTypes: const['.txt'],
  /// );
  ///
  /// fileSaver.writeAsBytesSync(bytes, context:context);
  /// ```
  void writeAsBytesSync(List<int> bytes,
      {required BuildContext context,
      mode = FileMode.write,
      bool flush = false}) async {
    String? path = await filebrowser(context, fileSaver: this);
    if (path != null) {
      _successMessage(context);
      if (File(path).existsSync()) {
        File(path).writeAsBytesSync(bytes, mode: FileMode.write, flush: flush);
      } else {
        File(path).writeAsBytesSync(bytes, mode: mode, flush: flush);
      }
    }
  }

  /// Calling [writeAsString](https://api.flutter.dev/flutter/dart-io/File/writeAsString.html) method.
  ///
  /// ```dart
  /// FileSaver fileSaver = FileSaver(
  ///   initialFileName:'File Name',
  ///   fileTypes: const['.txt'],
  /// );
  ///
  /// fileSaver.writeAsString(bytes, context:context);
  /// ```
  Future<File?> writeAsString(String contents,
      {required BuildContext context,
      mode = FileMode.write,
      Encoding encoding = utf8,
      bool flush = false}) async {
    String? path = await filebrowser(context, fileSaver: this);
    if (path != null) {
      _successMessage(context);
      if (File(path).existsSync()) {
        return File(path).writeAsString(contents,
            mode: FileMode.write, encoding: encoding, flush: flush);
      }
      return File(path).writeAsString(contents,
          mode: mode, encoding: encoding, flush: flush);
    }
    return null;
  }

  /// Calling [writeAsStringSync](https://api.flutter.dev/flutter/dart-io/File/writeAsStringSync.html) method.
  ///
  /// ```dart
  /// FileSaver fileSaver = FileSaver(
  ///   initialFileName:'File Name',
  ///   fileTypes: const['.txt'],
  /// );
  ///
  /// fileSaver.writeAsStringSync(bytes, context:context);
  /// ```
  void writeAsStringSync(String contents,
      {required BuildContext context,
      mode = FileMode.write,
      Encoding encoding = utf8,
      bool flush = false}) async {
    String? path = await filebrowser(context, fileSaver: this);
    if (path != null) {
      _successMessage(context);
      if (File(path).existsSync()) {
        File(path).writeAsStringSync(contents,
            mode: FileMode.write, encoding: encoding, flush: flush);
      } else {
        File(path).writeAsStringSync(contents,
            mode: mode, encoding: encoding, flush: flush);
      }
    }
  }
}
