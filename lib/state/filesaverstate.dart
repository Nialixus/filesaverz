import 'dart:io';
import 'dart:developer';
import 'package:flutter/material.dart';
import '../addons/initiatedirectory.dart';

class FileSaverState with ChangeNotifier {
  FileSaverState(
      {this.initialDirectory, required this.fileName, required this.fileTypes});
  Directory? initialDirectory;
  final String fileName;
  final List<String> fileTypes;

  List<FileSystemEntity> entityList = [];
  int fileIndex = 0;

  void initState() async {
    initialDirectory = await initDir(initialDirectory);
    log(initialDirectory!.path);
    entityList = await initialDirectory!.list().toList();
    notifyListeners();
  }

  void browse(Directory newDirectory) {
    initialDirectory = newDirectory;
    entityList = initialDirectory!.listSync();
    notifyListeners();
  }

  void selectIndexFile(int newIndex) {
    fileIndex = newIndex;
    notifyListeners();
  }
}
