import 'dart:io';
import 'package:flutter/material.dart';

import '../addons/pathgetter.dart';
import '../state/filesaverstate.dart';

export '../addons/confirmationdialogue.dart' hide toConfirm;

/// Opening an alert dialogue if file already exist.
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
                backgroundColor: state.style.secondaryColor,
                titleTextStyle: state.style.primaryTextStyle,
                contentTextStyle: state.style.secondaryTextStyle,
                title: Text(state.style.text!.popupTitle!),
                content: Text(state.style.text!.popupInformation!),
                actions: [
                  for (int x = 0; x < 2; x++)
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context, [false, true][x]);
                        },
                        child: Text([
                          state.style.text!.popupNo!,
                          state.style.text!.popupYes!
                        ][x])),
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
