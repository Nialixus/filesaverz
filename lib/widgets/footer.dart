import 'package:flutter/material.dart';

Widget footer(
        {required String fileName,
        required List<String> fileExtension,
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
                  fileExtension.length,
                  (index) => DropdownMenuItem(
                        child: Text(fileExtension[index]),
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
                onTap: () {},
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
