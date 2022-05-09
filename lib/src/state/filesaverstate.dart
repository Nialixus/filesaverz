import 'dart:io';
import 'package:flutter/material.dart';

import '/filesaverz.dart';
import '../addons/initiatedirectory.dart';

export '../state/filesaverstate.dart' hide FileSaverState;

/// State Manager of [FileSaver].
class FileSaverState with ChangeNotifier {
  /// Constructor for [FileSaver].
  FileSaverState(
      {this.initialDirectory,
      required this.fileName,
      required this.fileTypes,
      required this.multiPicker,
      required this.style});

  /// A custom style for [FileSaver] which containing [Color], [TextStyle], [FileSaverIcon] and [FileSaverText].
  ///
  /// ```dart
  /// FileSaverStyle style = FileSaverStyle(
  ///   primaryColor: Colors.orange,
  ///   text: FileSaverText(
  ///     popupNo: 'Nay',
  ///     popupYes: 'Sí',
  ///   ),
  ///   icons: [
  ///     FileSaverIcon.file(
  ///       icon: (path) => Image.file(File(path)),
  ///       fileType: 'jpg',
  ///     )
  ///   ]
  /// );
  /// ```
  final FileSaverStyle style;

  /// Choose whether you want to save file as `null`, pick file as `false` or pick files as `true`.
  final bool? multiPicker;

  /// An optional [Directory].
  ///
  /// Default value in android is calling a [MethodChannel] of [Environment.getExternalStorageDirectory](https://developer.android.com/reference/android/os/Environment#getExternalStorageDirectory()).
  Directory? initialDirectory;

  /// An initial file name.
  ///
  /// ```dart
  /// String fileName = 'Untitled File';
  /// ```
  final String fileName;

  /// Giving user option to choose which file type to write.
  ///
  /// And also this [fileTypes] will be used as a parameter
  /// to displayed these file types only in file explorer.
  ///
  /// ```dart
  /// List<String> fileTypes = ['txt','rtf','html'];
  /// ```
  final List<String> fileTypes;

  /// List of selected paths from multipicker.
  List<String> selectedPaths = [];

  /// Add or remove selected path from multipicker.
  void changeSelectedPaths(String path) {
    if (selectedPaths.contains(path)) {
      selectedPaths.removeWhere((element) => element == path);
      notifyListeners();
    } else {
      selectedPaths.add(path);
      notifyListeners();
    }
  }

  /// Default controller of [TextField] in `footer` widget.
  TextEditingController controller = TextEditingController();

  /// List of file or direcory in path.
  List<FileSystemEntity> entityList = [];

  /// Selected index of [fileTypes].
  int fileIndex = 0;

  /// Setting initial directory and getting list of filesystem entity in the directory.
  void initState() async {
    Directory newDirectory;
    try {
      newDirectory = await initDir(initialDirectory);
    } catch (e) {
      newDirectory = await Directory.systemTemp.exists()
          ? Directory.systemTemp
          : Directory.current;
    }
    initialDirectory = newDirectory;
    entityList = newDirectory.listSync();
    notifyListeners();
  }

  /// Change path of directory and getting list of filesystem entity in the directory.
  void browse(Directory newDirectory) {
    /// Permission detector.
    bool permitted;

    /// Check whether user have permission or not.
    try {
      newDirectory.listSync();
      permitted = true;
    } catch (e) {
      permitted = false;
    }
    if (permitted) {
      initialDirectory = newDirectory;
      entityList = newDirectory.listSync();
      notifyListeners();
    }
  }

  /// Go back to previous directory.
  Future<bool> back() async {
    try {
      initialDirectory = initialDirectory!.parent;
      entityList = initialDirectory!.listSync();
      notifyListeners();
      return false;
    } catch (e) {
      return true;
    }
  }

  /// Change selected index of [fileTypes].
  void selectIndexFile(int newIndex) {
    fileIndex = newIndex;
    notifyListeners();
  }
}
