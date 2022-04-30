import 'dart:io';
import 'package:flutter/material.dart';
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

  /// A customable [FilePicker] where you can edit the widget which will be used as file explorer.
  ///
  /// ```dart
  /// FilePicker.builder(
  ///   multiPicker: false,
  ///   fileTypes: const ['jpg','gif'],
  ///   headerBuilder: (context, state) => Widget(),
  ///   bodyBuilder: (context, state) => Widget(),
  ///   footerBuilder: (context, state) => Widget(),
  /// );
  /// ```
  FilePicker.builder({
    Key? key,
    this.style,
    this.fileTypes,
    this.initialDirectory,
    this.multiPicker = false,
    Widget? Function(BuildContext context, FileSaverState state)? bodyBuilder,
    Widget? Function(BuildContext context, FileSaverState state)? headerBuilder,
    Widget? Function(BuildContext context, FileSaverState state)? footerBuilder,
  })  : headerBuilder = Consumer<FileSaverState>(
            builder: (context, value, child) => headerBuilder == null
                ? header(
                    multipicker: multiPicker,
                    context: context,
                    state: value,
                    style: style ?? FileSaverStyle())
                : headerBuilder(context, value)!),
        bodyBuilder = Consumer<FileSaverState>(
            builder: (context, value, child) => bodyBuilder == null
                ? body(
                    multipicker: multiPicker,
                    context: context,
                    state: value,
                    style: style ?? FileSaverStyle())
                : bodyBuilder(context, value)!),
        footerBuilder = Consumer<FileSaverState>(
            builder: (context, value, child) => footerBuilder == null
                ? footer(
                    multipicker: multiPicker,
                    context: context,
                    state: value,
                    style: style ?? FileSaverStyle())
                : footerBuilder(context, value)!),
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

  FilePicker copyWith(
          {Key? key,
          bool? multiPicker,
          FileSaverStyle? style,
          List<String>? fileTypes,
          Directory? initialDirectory,
          Widget? Function(BuildContext context, FileSaverState state)?
              headerBuilder}) =>
      FilePicker.builder(
          key: key ?? this.key,
          style: style ?? this.style,
          fileTypes: fileTypes ?? this.fileTypes,
          multiPicker: multiPicker ?? this.multiPicker,
          initialDirectory: initialDirectory ?? this.initialDirectory,
          headerBuilder: headerBuilder ??
              (context, state) => header(
                  multipicker: multiPicker ?? this.multiPicker,
                  context: context,
                  state: state,
                  style: style ?? this.style!));
}
