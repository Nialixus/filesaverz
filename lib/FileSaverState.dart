import 'dart:io';
import 'package:flutter/material.dart';

import 'addons/initiateDirectory.dart';

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

    final path = await initiateDirectory();
    print(path);
  }

  void browse(Directory newDirectory) {
    initialDirectory = newDirectory;
    entityList = initialDirectory!.listSync();
    notifyListeners();
  }
}
