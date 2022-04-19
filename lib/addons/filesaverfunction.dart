import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '../filesaver.dart';
import '../state/filesaverstate.dart';

Future<String?> savefunction(BuildContext context, FileSaver fileSaver) async {
  Permission storage = Permission.storage;
  await storage.request();
  PermissionStatus permissionStatus = await storage.status;

  if (permissionStatus.isDenied) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Storage Access Denied'),
        backgroundColor: Colors.red,
      ),
    );
    return null;
  } else {
    return showDialog<String>(
      context: context,
      barrierColor: Colors.transparent,
      builder: (context) => WillPopScope(
        onWillPop: () async {
          Navigator.pop(context, null);
          return true;
        },
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: 1),
          duration: const Duration(milliseconds: 300),
          builder: (context, value, child) => FractionalTranslation(
              translation: Offset(0, 1 - value), child: fileSaver),
        ),
      ),
    );
  }
}

String resultFunction(FileSaverState state) {
  String pathResult = state.initialDirectory!.path;
  String nameResult =
      state.controller.text != '' ? state.controller.text : state.fileName;
  String dotSplitter = state.fileTypes.isEmpty
      ? ''
      : state.fileTypes[state.fileIndex].contains('.')
          ? ''
          : '.';
  String typeResult =
      state.fileTypes.isEmpty ? '' : state.fileTypes[state.fileIndex];

  return '$pathResult/$nameResult$dotSplitter$typeResult';
}

void overwriteFunction(BuildContext context, FileSaverState state) async {
  if (File(resultFunction(state)).existsSync()) {
    bool? confirmationResult = await showDialog<bool>(
        context: context,
        builder: (context) => WillPopScope(
              onWillPop: () async {
                Navigator.pop(context, false);
                return true;
              },
              child: AlertDialog(
                title: const Text('Confirmation'),
                content: const Text(
                    'File already exists.\nDo you want to replace it?'),
                actions: [
                  for (int x = 0; x < 2; x++)
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context, [false, true][x]);
                        },
                        child: Text(['NO', 'YES'][x])),
                ],
              ),
            ));

    if (confirmationResult == true) {
      Navigator.pop(context, resultFunction(state));
    }
  } else {
    Navigator.pop(context, resultFunction(state));
  }
}
