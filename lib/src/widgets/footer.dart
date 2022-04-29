import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '/filesaver.dart';
import '../addons/confirmationdialogue.dart';
import '../state/filesaverstate.dart';

export '../widgets/footer.dart' hide footer;

/// Default footer of [FileSaver].
///
/// This [Widget] contains [TextField] which will be used to input a new file name and replaced [fileName].\
/// Plus [DropdownButton] to display list of [fileTypes].
Widget footer(
    {bool? multipicker,
    required BuildContext context,
    required FileSaverState state,
    required FileSaverStyle style}) {
  return multipicker == null
      ? save(context, state, style)
      : multipicker == false
          ? pick()
          : pickFiles();
}

Widget pick() => Text('pick');

Widget pickFiles() => Text('pick Files');

Widget save(BuildContext context, FileSaverState state, FileSaverStyle style) =>
    Container(
      padding: const EdgeInsets.symmetric(
          horizontal: NavigationToolbar.kMiddleSpacing),
      height: kToolbarHeight,
      decoration: BoxDecoration(color: style.secondaryColor, boxShadow: [
        BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)
      ]),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: TextField(
                  controller: state.controller,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r'[-a-zA-Z0-9_\s]'))
                  ],
                  decoration: InputDecoration(
                      hintText: state.fileName,
                      hintStyle: style.secondaryTextStyle!.copyWith(
                          fontWeight: FontWeight.normal,
                          color: style.secondaryTextStyle!.color
                              ?.withOpacity(0.5)),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none))),
          state.fileTypes.isEmpty
              ? const SizedBox()
              : Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: NavigationToolbar.kMiddleSpacing),
                  child: Consumer<FileSaverState>(
                    builder: (context, value, child) => DropdownButton<int>(
                      underline: const SizedBox(),
                      items: List.generate(
                          state.fileTypes.length,
                          (index) => DropdownMenuItem(
                                child: Text(
                                  state.fileTypes[index],
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
              color: style.primaryColor!,
              child: InkWell(
                onTap: () async => toConfirm(context, state),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Text(
                    'Save',
                    style: style.primaryTextStyle!.copyWith(fontSize: 14),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
