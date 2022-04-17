import 'dart:io';
import 'package:flutter/material.dart';

import 'addons/initiateDirectory.dart';

class FileSaverState with ChangeNotifier {
  FileSaverState({this.initialDirectory});
  Directory? initialDirectory;

  List<FileSystemEntity> entityList = [];

  void initState() async {
    initialDirectory = await initDir(initialDirectory);
    print(initialDirectory);
    entityList = initialDirectory!.listSync();
  }

  void browse(Directory newDirectory) {
    initialDirectory = newDirectory;
    entityList = initialDirectory!.listSync();
    notifyListeners();
  }
}
