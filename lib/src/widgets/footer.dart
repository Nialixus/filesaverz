import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '/filesaverz.dart';
import '../addons/confirmationdialogue.dart';
import '../state/filesaverstate.dart';

export '../widgets/footer.dart' hide footer, pick, pickFiles, save;

/// Default footer of [FileSaver].
///
/// This [Widget] contains [TextField] which will be used to input a new file name and replaced [fileName].
/// Plus [DropdownButton] to display list of file types.
Widget footer({required BuildContext context, required FileSaverState state}) {
  return state.multiPicker == null
      ? save(context, state)
      : state.multiPicker == false
          ? pick()
          : pickFiles(context, state);
}

/// File Picker.
Widget pick() => const SizedBox();

/// Files Picker.
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
              '$length ${length > 1 ? state.style.text!.infoMultipleSelected : state.style.text!.infoSelected}',
              style: state.style.secondaryTextStyle,
            ),
          ),
        ),
        Tooltip(
          message: state.style.text!.buttonDone,
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
                  state.style.text!.buttonDone!,
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

/// File Saver
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
                  style: state.style.secondaryTextStyle,
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
                    builder: (context, value, child) => Tooltip(
                      message: state.style.text!.buttonFileTypes,
                      child: DropdownButton<int>(
                        underline: const SizedBox(),
                        dropdownColor: state.style.secondaryColor,
                        iconEnabledColor: state.style.secondaryTextStyle!.color,
                        items: List.generate(
                            state.fileTypes.length,
                            (index) => DropdownMenuItem(
                                  child: Text(
                                    state.fileTypes[index],
                                    style: state.style.secondaryTextStyle,
                                  ),
                                  value: index,
                                )),
                        value: value.fileIndex,
                        onChanged: (change) =>
                            value.selectIndexFile(change ?? 0),
                      ),
                    ),
                  ),
                ),
          Tooltip(
            message: state.style.text!.buttonSave,
            preferBelow: false,
            child: Material(
              color: state.style.primaryColor,
              child: InkWell(
                onTap: () async => toConfirm(context, state),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Text(
                    state.style.text!.buttonSave!,
                    style: state.style.primaryTextStyle?.copyWith(fontSize: 14),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
