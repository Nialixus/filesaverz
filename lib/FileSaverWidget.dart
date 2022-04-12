import 'dart:developer';
import 'dart:io';
import '../FileSaverState.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

List<String> months = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'November',
  'December'
];

class FileSaverWidget {
  static PreferredSizeWidget header(
          {required Color primaryColor,
          required TextStyle primaryTextStyle,
          required Color secondaryColor}) =>
      AppBar(
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

  static Widget body(
          {required Color primaryColor,
          required Color secondaryColor,
          required TextStyle secondaryTextStyle}) =>
      Consumer<FileSaverState>(builder: (context, value, child) {
        String directoryPath =
            value.initialDirectory == null ? '/' : value.initialDirectory!.path;

        return Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              height: kToolbarHeight,
              width: MediaQuery.of(context).size.width,
              child: directoryPath.split('/').length > 2
                  ? SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(20),
                              onTap: () {
                                value.browse(Directory(directoryPath).parent);
                              },
                              child: Container(
                                constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(context).size.width *
                                            0.5),
                                padding: const EdgeInsets.symmetric(
                                    horizontal:
                                        NavigationToolbar.kMiddleSpacing,
                                    vertical: 5.0),
                                child: Text(
                                  Directory(directoryPath)
                                      .parent
                                      .path
                                      .split('/')
                                      .last,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios_sharp, size: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: NavigationToolbar.kMiddleSpacing,
                                vertical: 5.0),
                            child: Text(
                              directoryPath.split('/').last,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: secondaryTextStyle,
                            ),
                          )
                        ],
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: NavigationToolbar.kMiddleSpacing,
                          vertical: 5.0),
                      child: Text(
                        directoryPath,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: secondaryTextStyle,
                      ),
                    ),
            ),
            Expanded(
              child: Scrollbar(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    ///Default Text
                    String itemName =
                        value.entityList[index].path.split('/').last;
                    String itemExt = value.entityList[index] is File
                        ? itemName.split('.').last
                        : '';
                    DateTime dateTime =
                        value.entityList[index].statSync().modified;

                    ///Default Icon
                    Widget icon = value.entityList[index] is File
                        ? Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              Icon(
                                Icons.insert_drive_file_sharp,
                                color: primaryColor.withOpacity(0.35),
                                size: kToolbarHeight,
                              ),
                              Container(
                                  decoration: BoxDecoration(
                                      color: secondaryColor,
                                      border: Border.all(
                                          width: 1, color: primaryColor)),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 2.5),
                                  child: Row(
                                    children: [
                                      Text(
                                        (itemExt.characters.length >= 3
                                                ? itemExt.substring(0, 3)
                                                : itemExt)
                                            .toUpperCase(),
                                        style: secondaryTextStyle.copyWith(
                                            fontSize: 10, color: primaryColor),
                                      ),
                                    ],
                                  ))
                            ],
                          )
                        : Icon(
                            Icons.folder_sharp,
                            color: primaryColor.withOpacity(0.75),
                            size: kToolbarHeight,
                          );

                    return Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          if (value.entityList[index] is Directory) {
                            value.browse(value.entityList[index] as Directory);
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: NavigationToolbar.kMiddleSpacing),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              icon,
                              const SizedBox(width: 5),
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    itemName,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: secondaryTextStyle,
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    'Modified on ${dateTime.day} ${months[dateTime.month - 1]} ${dateTime.year}',
                                    style: secondaryTextStyle.copyWith(
                                        color: secondaryTextStyle.color
                                            ?.withOpacity(0.25),
                                        fontWeight: FontWeight.normal,
                                        fontSize: 11),
                                  )
                                ],
                              ))
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  scrollDirection: Axis.vertical,
                  itemCount: value.entityList.length,
                  shrinkWrap: true,
                ),
              ),
            ),
          ],
        );
      });

  static Widget footer(
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
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
}
