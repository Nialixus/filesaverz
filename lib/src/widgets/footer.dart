import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '/filesaverz.dart';
import '../addons/confirmationdialogue.dart';
import '../state/filesaverstate.dart';

export '../widgets/footer.dart' hide footer, pick, pickFiles, save;

/// Default footer of [FileSaver].
///
/// This [Widget] contains [TextField] which will be used to input a new file name and replaced [fileName].\
/// Plus [DropdownButton] to display list of [fileTypes].
Widget footer({required BuildContext context, required FileSaverState state}) {
  return state.multiPicker == null
      ? save(context, state)
      : state.multiPicker == false
          ? pick()
          : pickFiles(context, state);
}

Widget pick() => const SizedBox();

Widget pickFiles(BuildContext context, FileSaverState state) {
  int length = state.selectedPaths.length;
  return Container(
    padding: const EdgeInsets.symmetric(
        horizontal: NavigationToolbar.kMiddleSpacing),
    height: kToolbarHeight,
    decoration: BoxDecoration(color: state.style.secondaryColor, boxShadow: [
      BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)
    ]),
    child: Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              '$length file${length > 1 ? 's' : ''} selected',
              style: state.style.secondaryTextStyle,
            ),
          ),
        ),
        Tooltip(
          message: 'Done',
          preferBelow: false,
          child: Material(
            color: state.style.primaryColor,
            child: InkWell(
              onTap: () => Navigator.pop(
                  context, length == 0 ? null : state.selectedPaths.toString()),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Text(
                  'Done',
                  style: state.style.primaryTextStyle?.copyWith(fontSize: 14),
                ),
              ),
            ),
          ),
        )
      ],
    ),
  );
}

Widget save(BuildContext context, FileSaverState state) => Container(
      padding: const EdgeInsets.symmetric(
          horizontal: NavigationToolbar.kMiddleSpacing),
      height: kToolbarHeight,
      decoration: BoxDecoration(color: state.style.secondaryColor, boxShadow: [
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
                      hintStyle: state.style.secondaryTextStyle?.copyWith(
                          fontWeight: FontWeight.normal,
                          color: state.style.secondaryTextStyle?.color
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
              color: state.style.primaryColor,
              child: InkWell(
                onTap: () async => toConfirm(context, state),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Text(
                    'Save',
                    style: state.style.primaryTextStyle?.copyWith(fontSize: 14),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
