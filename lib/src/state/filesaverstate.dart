import 'dart:io';
import 'package:flutter/material.dart';

import 'package:filesaverz/filesaver.dart';
import '../addons/initiatedirectory.dart';

export '../state/filesaverstate.dart' hide FileSaverState;

/// State Manager of [FileSaver].
class FileSaverState with ChangeNotifier {
  /// This class is automatically called in [FileSaver] build.
  FileSaverState.saver(
      {this.initialDirectory, required this.fileName, required this.fileTypes});

  FileSaverState.picker()
      : initialDirectory = null,
        fileName = '',
        fileTypes = [''];

  /// An optional initial directory.
  Directory? initialDirectory;

  /// An initial file name.
  ///
  /// ```dart
  /// String fileName = 'New File';
  /// ```
  final String fileName;

  /// A list of file types.
  ///
  /// ```dart
  /// List<String> fileTypes = ['txt','pdf'];
  /// ```
  final List<String> fileTypes;

  /// Default controller of [TextField] in `footer` widget.
  TextEditingController controller = TextEditingController();

  /// List of file or direcory in path.
  List<FileSystemEntity> entityList = [];

  /// Selected index of [fileTypes].
  int fileIndex = 0;

  /// Setting initial directory and getting list of filesystem entity in the directory.
  void initState() async {
    initialDirectory = await initDir(initialDirectory);
    entityList = initialDirectory!.listSync();
    notifyListeners();
  }

  /// Change path of directory and getting list of filesystem entity in the directory.
  void browse(Directory newDirectory) {
    initialDirectory = newDirectory;
    entityList = initialDirectory!.listSync();
    notifyListeners();
  }

  /// Change selected index of [fileTypes].
  void selectIndexFile(int newIndex) {
    fileIndex = newIndex;
    notifyListeners();
  }
}
