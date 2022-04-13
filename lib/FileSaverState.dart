import 'dart:io';
import 'package:flutter/material.dart';

class FileSaverState with ChangeNotifier {
  FileSaverState({this.initialDirectory});
  Directory? initialDirectory;

  List<FileSystemEntity> entityList = [];

  void initState() async {
    initialDirectory = initialDirectory ??
        (Directory.systemTemp.existsSync() == false
            ? Directory.current
            : Directory.systemTemp);
    entityList = initialDirectory!.listSync();
  }

  void browse(Directory newDirectory) async {
    initialDirectory = newDirectory;
    entityList = await initialDirectory!.list().toList();
    notifyListeners();
  }
}
