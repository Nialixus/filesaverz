part of 'package:filesaver/filesaver.dart';

extension FileSaverExtension on FileSaver {
  Future<String?> getPath(BuildContext context) => filebrowser(context, this);

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
