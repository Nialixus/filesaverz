import 'dart:io';
import 'package:flutter/material.dart';

import 'package:filesaverz/filesaver.dart';
import '../addons/bytesconverter.dart';
import '../addons/characterlimiter.dart';
import '../addons/datesconverter.dart';
import '../addons/confirmationdialogue.dart';
import '../state/filesaverstate.dart';

export '../widgets/body.dart' hide body, address, empty, notEmpty, icon;

/// Default body [Widget] of [FileSaver].
Widget body(
    {bool? multipicker,
    required BuildContext context,
    required FileSaverState state,
    required FileSaverStyle style}) {
  return Column(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      address(context, state, style),
      state.entityList.isEmpty
          ? empty(style)
          : notEmpty(multipicker, state, style)
    ],
  );
}

/// This display the current address of path we're at.
Widget address(
    BuildContext context, FileSaverState state, FileSaverStyle style) {
  String directoryPath =
      state.initialDirectory == null ? '/' : state.initialDirectory!.path;
  return Container(
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
                    style: style.secondaryTextStyle,
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
              style: style.secondaryTextStyle,
            ),
          ),
  );
}

/// This [Widget] will be displayed if list of [FileSystemEntity] is empty.
Widget empty(FileSaverStyle style) => Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.folder_sharp,
            color: style.primaryColor!.withOpacity(0.25),
            size: kToolbarHeight,
          ),
          Text(
            'Folder is empty',
            style: TextStyle(
                color: style.secondaryTextStyle?.color?.withOpacity(0.25),
                fontWeight: FontWeight.normal),
          )
        ],
      ),
    );

/// This [Widget] will be displayed if list of [FileSystemEntity] is not empty.
Widget notEmpty(bool? multiPicker, FileSaverState state, FileSaverStyle style) {
  List<FileSystemEntity> newList = state.fileTypes.isEmpty
      ? state.entityList
      : state.entityList.where((element) {
          if (element is Directory) {
            return true;
          } else {
            return state.fileTypes
                .any((fileTypes) => element.path.endsWith(fileTypes));
          }
        }).toList();
  return Expanded(
    child: Scrollbar(
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          FileSystemEntity entity = newList[index];
          String itemName = entity.path.split('/').last;

          return Material(
            color: state.selectedPaths.contains(entity.path)
                ? Colors.black.withOpacity(0.1)
                : Colors.transparent,
            child: InkWell(
              splashColor: Colors.transparent,
              onDoubleTap: () {
                if (newList[index] is File) {
                  if (multiPicker == null) {
                    state.controller.text = itemName.split('.').first;
                    toConfirm(context, state);
                  } else if (multiPicker == false) {
                    Navigator.pop(context, entity.path);
                  } else {
                    state.changeSelectedPaths(entity.path);
                  }
                }
              },
              onTap: () {
                if (entity is Directory) {
                  state.browse(entity);
                } else if (entity is File) {
                  if (multiPicker == null) {
                    state.controller.text = itemName.split('.').first;
                  } else if (multiPicker == false) {
                    Navigator.pop(context, entity.path);
                  } else {
                    state.changeSelectedPaths(entity.path);
                  }
                }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 5, horizontal: NavigationToolbar.kMiddleSpacing),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    icon(style, newList[index]),
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
                          style: style.secondaryTextStyle,
                        ),
                        const SizedBox(height: 5),
                        DefaultTextStyle(
                            style: style.secondaryTextStyle!.copyWith(
                                color: style.secondaryTextStyle!.color
                                    ?.withOpacity(0.25),
                                fontWeight: FontWeight.normal,
                                fontSize: 11),
                            child: Text.rich(TextSpan(children: [
                              TextSpan(
                                  text:
                                      '${newList[index].statSync().modified.convertToDates()}   '),
                              newList[index] is File
                                  ? TextSpan(
                                      text:
                                          '|   ${(newList[index] as File).statSync().size.convertToBytes()}')
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
        itemCount: newList.length,
        shrinkWrap: true,
      ),
    ),
  );
}

/// Customable icon from [FileSaverIcon].
Widget icon(
  FileSaverStyle style,
  FileSystemEntity entity,
) {
  String extension = entity.path.contains('.')
      ? entity.path.split('.').last.toLimit(4)
      : entity.path.split('/').last.toLimit(4);

  /// Default icon for [FIleSaverIcon.file].
  Widget defaultFileIcon = Stack(
    alignment: Alignment.bottomCenter,
    children: [
      Icon(
        Icons.insert_drive_file_sharp,
        color: style.primaryColor!.withOpacity(0.35),
        size: kToolbarHeight,
      ),
      Container(
          decoration: BoxDecoration(
              color: style.secondaryColor!,
              border: Border.all(width: 1, color: style.primaryColor!)),
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2.5),
          child: Row(
            children: [
              Text(
                extension.toUpperCase(),
                style: style.secondaryTextStyle!
                    .copyWith(fontSize: 10, color: style.primaryColor!),
              ),
            ],
          ))
    ],
  );

  /// Default icon for [FileSaverIcon.directory].
  Widget defaultDirectoryIcon = Icon(
    Icons.folder_sharp,
    color: style.primaryColor!.withOpacity(0.75),
    size: kToolbarHeight,
  );

  if (entity is File) {
    /// Listing every [FIleSaverIcon.file] from list;
    List<FileSaverIcon> newList =
        style.icons!.where((fsi) => fsi.type == File).toList();

    /// If [fileType] equals to [entity.path] then returning custom file icon.
    if (newList.any((fsi) => fsi.fileType == entity.path.split('.').last)) {
      return newList
          .lastWhere((fsi) => fsi.fileType == entity.path.split('.').last)
          .icon(entity.path);
    } else if (newList.any((fsi) => fsi.fileType == 'filesavericon.default')) {
      return newList
          .lastWhere((fsi) => fsi.fileType == 'filesavericon.default')
          .icon(entity.path);
    }

    return defaultFileIcon;
  } else {
    /// If [FilesaverIcon.directory] exist then returning custom directory icon.
    if (style.icons!.any((fsi) => fsi.type == Directory)) {
      return style.icons!
          .lastWhere((fsi) => fsi.type == Directory)
          .icon(entity.path);
    }

    return defaultDirectoryIcon;
  }
}
