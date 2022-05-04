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
              ? 'Save File'
              : state.multiPicker == false
                  ? 'Pick File'
                  : 'Pick Files',
          style: state.style.primaryTextStyle,
        )),
        Tooltip(
            message: 'Close',
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
                            color: state.style.secondaryColor)))))
      ]),
    );
