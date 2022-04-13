import 'package:flutter/material.dart';
import 'package:filesaver/filesaver.dart';
import 'package:provider/provider.dart';

import '../FileSaverState.dart';

///Default header for [FileSaver].
Widget header({
  required BuildContext context,
  required FileSaverState state,
  required Color primaryColor,
  required Color secondaryColor,
  required TextStyle primaryTextStyle,
}) =>
    Row(children: [
      const SizedBox(width: NavigationToolbar.kMiddleSpacing),
      const Expanded(child: Text('Save File')),
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
                      child: Icon(Icons.clear, color: secondaryColor)))))
    ]);
