import 'package:flutter/material.dart';

PreferredSizeWidget header(
    {required Color primaryColor,
    required Color secondaryColor,
    required TextStyle primaryTextStyle}) {
  return AppBar(
      backgroundColor: primaryColor,
      titleSpacing: 0,
      titleTextStyle: primaryTextStyle,
      title: Row(
        children: [
          const SizedBox(
            width: NavigationToolbar.kMiddleSpacing,
          ),
          const Expanded(
              child: Text(
            'Save File',
          )),
          Tooltip(
            message: 'Close',
            child: Material(
                color: Colors.transparent,
                shape: const CircleBorder(),
                child: InkWell(
                    onTap: () {},
                    customBorder: const CircleBorder(),
                    child: SizedBox(
                        height: kToolbarHeight,
                        width: kToolbarHeight,
                        child: Icon(Icons.clear, color: secondaryColor)))),
          )
        ],
      ));
}
