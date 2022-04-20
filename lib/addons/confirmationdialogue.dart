import 'dart:io';
import 'package:filesaver/addons/pathgetter.dart';
import 'package:flutter/material.dart';
import '../state/filesaverstate.dart';

void toConfirm(BuildContext context, FileSaverState state) async {
  if (File(pathGetter(state)).existsSync()) {
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
      Navigator.pop(context, pathGetter(state));
    }
  } else {
    Navigator.pop(context, pathGetter(state));
  }
}
