import 'package:flutter/material.dart';
import '../filesaver.dart';
import '../state/filesaverstate.dart';

///Default header for [FileSaver].
Widget header({
  required BuildContext context,
  required FileSaverState state,
  required FileSaverStyle style,
}) =>
    Container(
      height: kToolbarHeight,
      decoration: BoxDecoration(
        color: style.primaryColor,
      ),
      child: Row(mainAxisSize: MainAxisSize.max, children: [
        const SizedBox(width: NavigationToolbar.kMiddleSpacing),
        Expanded(
            child: Text(
          'Save File',
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
