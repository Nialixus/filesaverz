library filesaver;

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../addons/result.dart';
import '../widgets/header.dart';
import '../state/filesaverstate.dart';
import '../widgets/body.dart';
import '../widgets/footer.dart';

const Color fsPrimaryColor = Colors.blue;
const Color fsSecondaryColor = Colors.white;
const TextStyle fsPrimaryTextStyle =
    TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600);
const TextStyle fsSecondaryTextStyle =
    TextStyle(color: Colors.black87, fontWeight: FontWeight.bold);

///required [MediaQuery] widget ancestor
class FileSaver extends StatelessWidget {
  final Widget? headerBuilder, bodyBuilder, footerBuilder;
  final Color? primaryColor, secondaryColor;
  final TextStyle? primaryTextStyle, secondaryTextStyle;
  final String initialFileName;
  final Directory? initialDirectory;
  final List<String> fileExtensions;

  FileSaver.builder(
      {Key? key,
      required this.initialFileName,
      required this.fileExtensions,
      this.initialDirectory,
      Widget? Function(BuildContext context, FileSaverState state)?
          headerBuilder,
      Widget? Function(BuildContext context, FileSaverState state)? bodyBuilder,
      Widget? Function(BuildContext context, FileSaverState state)?
          footerBuilder,
      this.primaryColor,
      this.secondaryColor,
      this.primaryTextStyle,
      this.secondaryTextStyle})
      // ignore: prefer_typing_uninitialized_variables
      : headerBuilder = Consumer<FileSaverState>(
            builder: (context, value, child) => headerBuilder == null
                ? header(
                    context: context,
                    state: value,
                    primaryColor: primaryColor ?? fsPrimaryColor,
                    secondaryColor: secondaryColor ?? fsSecondaryColor,
                    primaryTextStyle: primaryTextStyle ?? fsPrimaryTextStyle)
                : headerBuilder(context, value)!),
        bodyBuilder = Consumer<FileSaverState>(
            builder: (context, value, child) => bodyBuilder == null
                ? body(
                    context: context,
                    state: value,
                    primaryColor: primaryColor ?? fsPrimaryColor,
                    secondaryColor: secondaryColor ?? fsSecondaryColor,
                    secondaryTextStyle:
                        secondaryTextStyle ?? fsSecondaryTextStyle)
                : bodyBuilder(context, value)!),
        footerBuilder = Consumer<FileSaverState>(
            builder: (context, value, child) => footerBuilder == null
                ? footer(
                    context: context,
                    state: value,
                    fileName: initialFileName,
                    primaryColor: primaryColor ?? fsPrimaryColor,
                    secondaryColor: secondaryColor ?? fsSecondaryColor,
                    fileExtensions: fileExtensions,
                    primaryTextStyle: primaryTextStyle ?? fsPrimaryTextStyle,
                    secondaryTextStyle:
                        secondaryTextStyle ?? fsSecondaryTextStyle)
                : footerBuilder(context, value)!),
        super(key: key);

  FileSaver(
      {Key? key,
      required this.initialFileName,
      required this.fileExtensions,
      this.initialDirectory,
      this.primaryColor,
      this.secondaryColor,
      this.primaryTextStyle,
      this.secondaryTextStyle})
      : headerBuilder = Consumer<FileSaverState>(
            builder: (context, value, child) => header(
                context: context,
                state: value,
                primaryColor: primaryColor ?? fsPrimaryColor,
                secondaryColor: secondaryColor ?? fsSecondaryColor,
                primaryTextStyle: primaryTextStyle ?? fsPrimaryTextStyle)),
        bodyBuilder = Consumer<FileSaverState>(
            builder: (context, value, child) => body(
                context: context,
                state: value,
                primaryColor: primaryColor ?? fsPrimaryColor,
                secondaryColor: secondaryColor ?? fsSecondaryColor,
                secondaryTextStyle:
                    secondaryTextStyle ?? fsSecondaryTextStyle)),
        footerBuilder = Consumer<FileSaverState>(
            builder: (context, value, child) => footer(
                context: context,
                state: value,
                fileName: initialFileName,
                primaryColor: primaryColor ?? fsPrimaryColor,
                secondaryColor: secondaryColor ?? fsSecondaryColor,
                fileExtensions: fileExtensions,
                primaryTextStyle: primaryTextStyle ?? fsPrimaryTextStyle,
                secondaryTextStyle:
                    secondaryTextStyle ?? fsSecondaryTextStyle)),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => FileSaverState(initialDirectory: initialDirectory),
        builder: (providerContext, providerChild) {
          Provider.of<FileSaverState>(providerContext, listen: false)
              .initState();

          return Scaffold(
            backgroundColor: secondaryColor,
            body: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).padding.top,
                  color: primaryColor ?? fsPrimaryColor,
                ),
                headerBuilder!,
                Expanded(child: bodyBuilder!),
              ],
            ),
            bottomSheet: footerBuilder,
          );
        });
  }
}

extension FileSaverString on FileSaver {
  Future<String?> getString(BuildContext context) => result(context, this);
}
