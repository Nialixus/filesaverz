import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/filesaverstate.dart';

Widget footer(
    {required BuildContext context,
    required FileSaverState state,
    required String fileName,
    required List<String> fileTypes,
    required Color primaryColor,
    required Color secondaryColor,
    required TextStyle primaryTextStyle,
    required TextStyle secondaryTextStyle}) {
  return Container(
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
                controller: state.controller,
                decoration: InputDecoration(
                    hintText: fileName,
                    hintStyle: secondaryTextStyle.copyWith(
                        fontWeight: FontWeight.normal,
                        color: secondaryTextStyle.color?.withOpacity(0.5)),
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none))),
        fileTypes.isEmpty
            ? const SizedBox()
            : Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: NavigationToolbar.kMiddleSpacing),
                child: Consumer<FileSaverState>(
                  builder: (context, value, child) => DropdownButton<int>(
                    underline: const SizedBox(),
                    items: List.generate(
                        fileTypes.length,
                        (index) => DropdownMenuItem(
                              child: Text(
                                fileTypes[index],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              value: index,
                            )),
                    value: value.fileIndex,
                    onChanged: (change) => value.selectIndexFile(change ?? 0),
                  ),
                ),
              ),
        Tooltip(
          message: 'Save',
          preferBelow: false,
          child: Material(
            color: primaryColor,
            child: InkWell(
              onTap: () => Navigator.pop(context,
                  '${state.initialDirectory?.path}/${state.controller.text != '' ? state.controller.text : state.fileName}${state.fileTypes[state.fileIndex].contains('.') ? '' : '.'}${state.fileTypes.isEmpty ? '' : state.fileTypes[state.fileIndex]}'),
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
}
