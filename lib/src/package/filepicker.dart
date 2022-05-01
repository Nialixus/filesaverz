import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '/filesaver.dart';
import '../widgets/body.dart';
import '../widgets/footer.dart';
import '../widgets/header.dart';
import '../state/filesaverstate.dart';

export '../package/filepicker.dart' hide FilePicker;

/// File explorer to browse and select folder path for picking file.
class FilePicker extends StatelessWidget {
  /// An optional header of [FileSaver].
  ///
  /// Default value is [header].
  final Widget? headerBuilder;

  /// An optional body of [FileSaver].
  ///
  /// Displaying list of [FileSystemEntity].
  /// Default value is [body].
  final Widget? bodyBuilder;

  /// An optional footer of [FileSaver].
  ///
  /// Displaying option to input file name and select file types.
  /// Default value is [footer].
  final Widget? footerBuilder;

  /// A custom style for [FileSaver] which containing [Color], [TextStyle] and customable icon [FileSaverIcon].
  ///
  /// ```dart
  /// FileSaverStyle style = FileSaverStyle(primaryColor: Colors.orange);
  /// ```
  final FileSaverStyle? style;

  /// An option of whether all files will be displayed or only certain files.
  final List<String>? fileTypes;

  /// Choose whether you want to get single file, or multiple files.
  final bool? multiPicker;

  /// An optional [Directory].
  ///
  /// Default value in android is calling a [MethodChannel] of [Environment.getExternalStorageDirectory](https://developer.android.com/reference/android/os/Environment#getExternalStorageDirectory()).
  final Directory? initialDirectory;

  /// Default file explorer for [FilePicker].
  ///
  /// ```dart
  /// FilePicker(
  ///   fileTypes: const ['txt','pdf'],
  ///   multiPicker: false,
  /// );
  /// ```
  FilePicker({
    Key? key,
    this.style,
    this.fileTypes,
    this.initialDirectory,
    this.multiPicker = false,
  })  : headerBuilder = Consumer<FileSaverState>(
            builder: (context, value, child) => header(
                multipicker: multiPicker,
                context: context,
                state: value,
                style: style ?? FileSaverStyle())),
        bodyBuilder = Consumer<FileSaverState>(
            builder: (context, value, child) => body(
                multipicker: multiPicker,
                context: context,
                state: value,
                style: style ?? FileSaverStyle())),
        footerBuilder = Consumer<FileSaverState>(
            builder: (context, value, child) => footer(
                multipicker: multiPicker,
                context: context,
                state: value,
                style: style ?? FileSaverStyle())),
        assert(multiPicker != null),
        assert(fileTypes != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => FileSaverState.picker(
            initialDirectory: initialDirectory,
            fileTypes: fileTypes ?? const []),
        builder: (providerContext, providerChild) {
          Provider.of<FileSaverState>(providerContext, listen: false)
              .initState();

          return Scaffold(
            backgroundColor: style?.secondaryColor,
            body: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  headerBuilder!,
                  Expanded(child: bodyBuilder!),
                ],
              ),
            ),
            bottomSheet: footerBuilder,
          );
        });
  }
}

/// A private extension for [FilePicker].
extension FilePickerExtension on FilePicker {
  /// Copying value of [FilePicker] and replace it with new desired value.
  FilePicker copyWith({
    Key? key,
    bool? multiPicker,
    FileSaverStyle? style,
    List<String>? fileTypes,
    Directory? initialDirectory,
  }) =>
      FilePicker(
        fileTypes: fileTypes ?? this.fileTypes,
        initialDirectory: initialDirectory ?? this.initialDirectory,
        key: key ?? this.key,
        multiPicker: multiPicker ?? this.multiPicker,
        style: style ?? this.style,
      );
}
