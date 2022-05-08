import 'package:flutter/material.dart';

import '/filesaverz.dart';
import '../state/filesaverstate.dart';

export '../widgets/header.dart' hide header;

/// Default header for [FileSaver].
///
/// This [Widget] only displaying title and close button.
Widget header({
  required BuildContext context,
  required FileSaverState state,
}) =>
    Container(
      height: kToolbarHeight,
      decoration: BoxDecoration(color: state.style.primaryColor),
      child: Row(mainAxisSize: MainAxisSize.max, children: [
        const SizedBox(width: NavigationToolbar.kMiddleSpacing),
        Expanded(
            child: Text(
          state.multiPicker == null
              ? state.style.text!.titleSaveFile
              : state.multiPicker == false
                  ? state.style.text!.titlePickFile
                  : state.style.text!.titlePickFiles,
          style: state.style.primaryTextStyle,
        )),
        Tooltip(
            message: state.style.text!.buttonClose,
            child: Material(
                color: Colors.transparent,
                shape: const CircleBorder(),
                child: InkWell(
                    onTap: () => Navigator.pop(context),
                    customBorder: const CircleBorder(),
                    child: SizedBox(
                        height: kToolbarHeight,
                        width: kToolbarHeight,
                        child: Icon(Icons.clear,
                            color: state.style.primaryTextStyle.color)))))
      ]),
    );
