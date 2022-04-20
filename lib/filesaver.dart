/// Libarary of [FileSaver].
///
/// A package that makes it easy for user to browse folder and save file.
library filesaver;

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../widgets/header.dart';
import '../widgets/body.dart';
import '../widgets/footer.dart';
import '../state/filesaverstate.dart';
import '../addons/filebrowser.dart';

part 'package:filesaver/styles/style.dart';
part 'package:filesaver/addons/extensionfunction.dart';

/// File explorer to browse and select folder path.
class FileSaver extends StatelessWidget {
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

  /// A custom style for [FileSaver] which containing [Color] and [TextStyle].
  ///
  /// ```dart
  /// FileSaverStyle style = FileSaverStyle(primaryColor: Colors.orange);
  /// ```
  final FileSaverStyle? style;

  /// Default name that will be saved later. If user insert a new name, than it will be replaced.
  ///
  /// ```dart
  /// String initialFileName = 'Untitled File';
  /// ```
  final String initialFileName;

  /// An optional [Directory].
  ///
  /// Default value in android is calling a [MethodChannel] of `Environment.getExternalStorageDirectory()`.
  /// Where another platform will using [Directory.systemTemp] and if it doesn't exist, it uses [Directory.current].
  final Directory? initialDirectory;

  /// A list [String] of file types.
  ///
  /// ```dart
  /// List<String> fileTypes = ['txt','rtf','html'];
  /// ```
  final List<String> fileTypes;

  /// A customable [FileSaver] where you can edit the widget which will be used as file explorer.
  ///
  /// ```dart
  /// FileSaver.builder(
  ///   initialFileName: 'New File',
  ///   headerBuilder: (context, state) => Widget(),
  ///   bodyBuilder: (context, state) => Widget(),
  ///   footerBuilder: (context, state) => Widget(),
  ///   fileTypes: const ['txt'],
  /// );
  /// ```
  FileSaver.builder({
    Key? key,
    required this.initialFileName,
    required this.fileTypes,
    this.initialDirectory,
    this.style,
    Widget? Function(BuildContext context, FileSaverState state)? headerBuilder,
    Widget? Function(BuildContext context, FileSaverState state)? bodyBuilder,
    Widget? Function(BuildContext context, FileSaverState state)? footerBuilder,
  })  : headerBuilder = Consumer<FileSaverState>(
            builder: (context, value, child) => headerBuilder == null
                ? header(
                    context: context,
                    state: value,
                    style: style ?? FileSaverStyle())
                : headerBuilder(context, value)!),
        bodyBuilder = Consumer<FileSaverState>(
            builder: (context, value, child) => bodyBuilder == null
                ? body(
                    context: context,
                    state: value,
                    style: style ?? FileSaverStyle())
                : bodyBuilder(context, value)!),
        footerBuilder = Consumer<FileSaverState>(
            builder: (context, value, child) => footerBuilder == null
                ? footer(
                    context: context,
                    state: value,
                    fileName: value.fileName,
                    fileTypes: value.fileTypes,
                    style: style ?? FileSaverStyle())
                : footerBuilder(context, value)!),
        super(key: key);

  /// Default file explorer for [FileSaver].
  ///
  /// ```dart
  /// FileSaver(
  ///   initialFileName: 'New File',
  ///   fileTypes: const ['.txt','.pdf'],
  /// );
  /// ```
  FileSaver(
      {Key? key,
      required this.initialFileName,
      required this.fileTypes,
      this.initialDirectory,
      this.style})
      : headerBuilder = Consumer<FileSaverState>(
            builder: (context, value, child) => header(
                context: context,
                state: value,
                style: style ?? FileSaverStyle())),
        bodyBuilder = Consumer<FileSaverState>(
            builder: (context, value, child) => body(
                context: context,
                state: value,
                style: style ?? FileSaverStyle())),
        footerBuilder = Consumer<FileSaverState>(
            builder: (context, value, child) => footer(
                context: context,
                state: value,
                fileName: value.fileName,
                fileTypes: value.fileTypes,
                style: style ?? FileSaverStyle())),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => FileSaverState(
            initialDirectory: initialDirectory,
            fileName: initialFileName,
            fileTypes: fileTypes),
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
