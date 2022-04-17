import 'package:flutter/material.dart';

import '../state/filesaverstate.dart';

Widget footer(
        {required BuildContext context,
        required FileSaverState state,
        required String fileName,
        required List<String> fileExtensions,
        required Color primaryColor,
        required Color secondaryColor,
        required TextStyle primaryTextStyle,
        required TextStyle secondaryTextStyle}) =>
    Container(
      padding: const EdgeInsets.symmetric(
          horizontal: NavigationToolbar.kMiddleSpacing),
      height: kToolbarHeight,
      decoration: BoxDecoration(color: secondaryColor, boxShadow: [
        BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)
      ]),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: TextField(
                  decoration: InputDecoration(
                      hintText: fileName,
                      hintStyle: secondaryTextStyle.copyWith(
                          fontWeight: FontWeight.normal,
                          color: secondaryTextStyle.color?.withOpacity(0.5)),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none))),
          Container(
            margin: const EdgeInsets.symmetric(
                horizontal: NavigationToolbar.kMiddleSpacing),
            child: DropdownButton<int>(
              underline: const SizedBox(),
              items: List.generate(
                  fileExtensions.length,
                  (index) => DropdownMenuItem(
                        child: Text(
                          fileExtensions[index],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        value: index,
                      )),
              value: 0,
              onChanged: (change) {},
            ),
          ),
          Tooltip(
            message: 'Save',
            preferBelow: false,
            child: Material(
              color: primaryColor,
              child: InkWell(
                onTap: () => Navigator.pop(context, 'suc'),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Text(
                    'Save',
                    style: primaryTextStyle.copyWith(fontSize: 14),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
