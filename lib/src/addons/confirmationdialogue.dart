import 'dart:io';
import 'package:flutter/material.dart';

import '../addons/pathgetter.dart';
import '../state/filesaverstate.dart';

export '../addons/confirmationdialogue.dart' hide toConfirm;

/// Opening an alert dialogue if file already exist.
void toConfirm(BuildContext context, FileSaverState state) async {
  if (File(pathGetter(state)).existsSync()) {
    showDialog<bool>(
        context: context,
        builder: (context) => PopScope(
              onPopInvoked: (val) async {
                Navigator.pop(context, false);
              },
              child: AlertDialog(
                backgroundColor: state.style.secondaryColor,
                title: Text(
                  state.style.text.popupTitle,
                  style: state.style.primaryTextStyle
                      .copyWith(color: state.style.primaryColor),
                ),
                content: Text(
                  state.style.text.popupInformation,
                  style: state.style.secondaryTextStyle
                      .copyWith(fontSize: 14, fontWeight: FontWeight.normal),
                ),
                actions: [
                  for (int x = 0; x < 2; x++)
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context, [false, true][x]);
                        },
                        child: Text(
                          [
                            state.style.text.popupNo,
                            state.style.text.popupYes
                          ][x],
                          style: state.style.primaryTextStyle.copyWith(
                              color: state.style.primaryColor, fontSize: 14),
                        )),
                ],
              ),
            )).then((value) {
      if (value == true) {
        Navigator.pop(context, pathGetter(state));
      }
    });
  } else {
    Navigator.pop(context, pathGetter(state));
  }
}
