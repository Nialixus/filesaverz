import 'package:flutter/material.dart';
import 'package:filesaverz/filesaver.dart';
import '../state/filesaverstate.dart';

export '../widgets/header.dart' hide header;

/// Default header for [FileSaver].
///
/// This [Widget] only displaying title and close button.
Widget header({
  bool? multipicker,
  required BuildContext context,
  required FileSaverState state,
  required FileSaverStyle style,
}) =>
    Container(
      height: kToolbarHeight,
      decoration: BoxDecoration(color: style.primaryColor),
      child: Row(mainAxisSize: MainAxisSize.max, children: [
        const SizedBox(width: NavigationToolbar.kMiddleSpacing),
        Expanded(
            child: Text(
          multipicker == null
              ? 'Save File'
              : multipicker == false
                  ? 'Pick File'
                  : 'Pick Files',
          style: style.primaryTextStyle,
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
                        child:
                            Icon(Icons.clear, color: style.secondaryColor)))))
      ]),
    );
