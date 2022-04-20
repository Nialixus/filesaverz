part of 'package:filesaver/filesaver.dart';

/// A group of extension for [FileSaver].
extension FileSaverExtension on FileSaver {
  /// Returning path from choosen [Directory] combined with file name and file type.
  ///
  /// ```dart
  /// FileSaver fileSaver = FileSaver(
  ///   initialFileName:'File Name',
  ///   fileTypes: const['.txt'],
  /// );
  /// String? path = await fileSaver.getPath(context);
  /// print(path); // storage/emulated/0/File Name.txt
  /// ```
  Future<String?> getPath(BuildContext context) => filebrowser(context, this);

  /// Calling `File(path).writeAsBytes()` function. This writes a list of bytes to a file. Opens the file, writes the list of bytes to it,
  /// and closes the file. Returns a Future<File> that completes with this [File] object once
  /// the entire operation has completed.
  ///
  /// By default [writeAsBytes] creates the file for writing and truncates the file if it already exists.
  ///
  /// In order to append the bytes to an existing file, pass [FileMode.append] as the optional mode parameter.
  ///
  /// If the argument [flush] is set to true, the data written will be flushed to the file system before
  /// the returned future completes.
  Future<File?> writeAsBytes(List<int> bytes,
      {required BuildContext context,
      mode = FileMode.write,
      bool flush = false}) async {
    String? path = await filebrowser(context, this);
    if (path != null) {
      if (File(path).existsSync()) {
        await File(path).delete();
        return File(path).writeAsBytes(bytes, mode: mode, flush: flush);
      } else {
        return File(path).writeAsBytes(bytes, mode: mode, flush: flush);
      }
    } else {
      return null;
    }
  }

  /// Calling `File(path).writeAsBytesSync()` function. Synchronously writes a list of bytes to a file. Opens the file, writes the list of bytes to it and closes the file.
  ///
  /// By default [writeAsBytesSync] creates the file for writing and truncates the file if it already exists.
  ///
  /// In order to append the bytes to an existing file, pass [FileMode.append] as the optional mode parameter.
  ///
  /// If the [flush] argument is set to true data written will be flushed to the file system before returning. Throws a [FileSystemException] if the operation fails.
  void writeAsBytesSync(List<int> bytes,
      {required BuildContext context,
      mode = FileMode.write,
      bool flush = false}) async {
    String? path = await filebrowser(context, this);
    if (path != null) {
      if (File(path).existsSync()) {
        await File(path).delete();
        File(path).writeAsBytesSync(bytes, mode: mode, flush: flush);
      } else {
        File(path).writeAsBytesSync(bytes, mode: mode, flush: flush);
      }
    }
  }

  /// Calling `File(path).writeAsString()` function. This Writes a string to a file.
  ///
  /// Opens the file, writes the string in the given encoding, and closes the file. Returns a Future<File> that completes with this [File] object once the entire operation has completed.
  ///
  /// By default [writeAsString] creates the file for writing and truncates the file if it already exists. In order to append the bytes to an existing file, pass [FileMode.append] as the optional mode parameter.
  ///
  /// If the argument [flush] is set to true, the data written will be flushed to the file system before the returned future completes.
  Future<File?> writeAsString(String contents,
      {required BuildContext context,
      mode = FileMode.write,
      Encoding encoding = utf8,
      bool flush = false}) async {
    String? path = await filebrowser(context, this);
    if (path != null) {
      if (File(path).existsSync()) {
        await File(path).delete();
        return File(path).writeAsString(contents,
            mode: mode, encoding: encoding, flush: flush);
      } else {
        return File(path).writeAsString(contents,
            mode: mode, encoding: encoding, flush: flush);
      }
    } else {
      return null;
    }
  }

  /// Calling `File(path).writeAsStringSync()` function. Synchronously writes a string to a file. Opens the file, writes the string in the given encoding, and closes the file.
  ///
  /// By default [writeAsStringSync] creates the file for writing and truncates the file if it already exists. In order to append the bytes to an existing file, pass [FileMode.append] as the optional mode parameter.
  void writeAsStringSync(String contents,
      {required BuildContext context,
      mode = FileMode.write,
      Encoding encoding = utf8,
      bool flush = false}) async {
    String? path = await filebrowser(context, this);
    if (path != null) {
      if (File(path).existsSync()) {
        await File(path).delete();
        File(path).writeAsStringSync(contents,
            mode: mode, encoding: encoding, flush: flush);
      } else {
        File(path).writeAsStringSync(contents,
            mode: mode, encoding: encoding, flush: flush);
      }
    }
  }
}
