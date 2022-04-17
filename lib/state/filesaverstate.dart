import 'dart:io';
import 'dart:developer';
import 'package:flutter/material.dart';
import '../addons/initiatedirectory.dart';

class FileSaverState with ChangeNotifier {
  FileSaverState({this.initialDirectory});
  Directory? initialDirectory;

  List<FileSystemEntity> entityList = [];

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
}
