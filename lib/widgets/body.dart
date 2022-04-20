import 'dart:io';
import 'package:flutter/material.dart';
import '../addons/bytesconverter.dart';
import '../addons/characterlimiter.dart';
import '../addons/datesconverter.dart';
import '../addons/confirmationdialogue.dart';
import '../filesaver.dart';
import '../state/filesaverstate.dart';

Widget body(
    {required BuildContext context,
    required FileSaverState state,
    required FileSaverStyle style}) {
  String directoryPath =
      state.initialDirectory == null ? '/' : state.initialDirectory!.path;

  return Column(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      address(context, directoryPath, state, style.secondaryTextStyle!),
      state.entityList.isEmpty
          ? empty(style.primaryColor!, style.secondaryTextStyle!)
          : notEmpty(state, style.primaryColor!, style.secondaryColor!,
              style.secondaryTextStyle!)
    ],
  );
}

Widget address(BuildContext context, String directoryPath, FileSaverState state,
        TextStyle secondaryTextStyle) =>
    Container(
      alignment: Alignment.centerLeft,
      height: kToolbarHeight,
      width: MediaQuery.of(context).size.width,
      child: directoryPath.split('/').length > 2
          ? Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => state.browse(Directory(directoryPath).parent),
                    child: Container(
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.75),
                      padding: const EdgeInsets.symmetric(
                          horizontal: NavigationToolbar.kMiddleSpacing,
                          vertical: 7.5),
                      child: Text(
                        Directory(directoryPath).parent.path.split('/').last,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
                const Icon(Icons.arrow_forward_ios_sharp, size: 20),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: NavigationToolbar.kMiddleSpacing,
                        vertical: 7.5),
                    child: Text(
                      directoryPath.split('/').last,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: secondaryTextStyle,
                    ),
                  ),
                )
              ],
            )
          : Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: NavigationToolbar.kMiddleSpacing, vertical: 7.5),
              child: Text(
                directoryPath,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: secondaryTextStyle,
              ),
            ),
    );

Widget empty(Color primaryColor, TextStyle secondaryTextStyle) => Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.folder_sharp,
            color: primaryColor.withOpacity(0.25),
            size: kToolbarHeight,
          ),
          Text(
            'Folder is empty',
            style: TextStyle(
                color: secondaryTextStyle.color!.withOpacity(0.25),
                fontWeight: FontWeight.normal),
          )
        ],
      ),
    );

Widget notEmpty(FileSaverState state, Color primaryColor, Color secondaryColor,
        TextStyle secondaryTextStyle) =>
    Expanded(
      child: Scrollbar(
        child: ListView.builder(
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            ///Default Text
            String itemName = state.entityList[index].path.split('/').last;
            String itemExt =
                state.entityList[index] is File ? itemName.split('.').last : '';

            ///Default Icon
            Widget icon = state.entityList[index] is File
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
                              border:
                                  Border.all(width: 1, color: primaryColor)),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 2.5),
                          child: Row(
                            children: [
                              Text(
                                itemExt.toLimit(4).toUpperCase(),
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
                splashColor: Colors.transparent,
                onDoubleTap: () {
                  if (state.entityList[index] is File) {
                    state.controller.text = itemName.split('.').first;
                    toConfirm(context, state);
                  }
                },
                onTap: () {
                  if (state.entityList[index] is Directory) {
                    state.browse(state.entityList[index] as Directory);
                  } else {
                    state.controller.text = itemName.split('.').first;
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
                          DefaultTextStyle(
                              style: secondaryTextStyle.copyWith(
                                  color: secondaryTextStyle.color
                                      ?.withOpacity(0.25),
                                  fontWeight: FontWeight.normal,
                                  fontSize: 11),
                              child: Text.rich(TextSpan(children: [
                                TextSpan(
                                    text:
                                        '${state.entityList[index].statSync().modified.convertToDates()}   '),
                                state.entityList[index] is File
                                    ? TextSpan(
                                        text:
                                            '|   ${(state.entityList[index] as File).statSync().size.convertToBytes()}')
                                    : const TextSpan()
                              ]))),
                        ],
                      ))
                    ],
                  ),
                ),
              ),
            );
          },
          scrollDirection: Axis.vertical,
          itemCount: state.entityList.length,
          shrinkWrap: true,
        ),
      ),
    );
