import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../filesaver.dart';
import '../src/widgets/body.dart';
import '../src/widgets/footer.dart';
import '../src/widgets/header.dart';
import '../src/state/filesaverstate.dart';

export '../filepicker.dart' hide FilePicker;

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
  final List<String>? displayedFileTypes;

  /// Choose whether you want to get single file, or multiple files.
  final bool? multiPicker;

  FilePicker({
    Key? key,
    this.style,
    this.multiPicker = false,
    this.displayedFileTypes = const [],
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
        assert(displayedFileTypes != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => FileSaverState.picker(),
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
