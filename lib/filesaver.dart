library filesaver;

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'addons/filesaverfunction.dart';
import '../widgets/header.dart';
import '../state/filesaverstate.dart';
import '../widgets/body.dart';
import '../widgets/footer.dart';
import '../styles/style.dart';

///required [MediaQuery] widget ancestor
class FileSaver extends StatelessWidget {
  final Widget? headerBuilder, bodyBuilder, footerBuilder;
  final Color? primaryColor, secondaryColor;
  final TextStyle? primaryTextStyle, secondaryTextStyle;
  final String initialFileName;
  final Directory? initialDirectory;
  final List<String> fileTypes;

  FileSaver.builder(
      {Key? key,
      required this.initialFileName,
      required this.fileTypes,
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
                    fileName: value.fileName,
                    primaryColor: primaryColor ?? fsPrimaryColor,
                    secondaryColor: secondaryColor ?? fsSecondaryColor,
                    fileTypes: value.fileTypes,
                    primaryTextStyle: primaryTextStyle ?? fsPrimaryTextStyle,
                    secondaryTextStyle:
                        secondaryTextStyle ?? fsSecondaryTextStyle)
                : footerBuilder(context, value)!),
        super(key: key);

  FileSaver(
      {Key? key,
      required this.initialFileName,
      required this.fileTypes,
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
                fileName: value.fileName,
                primaryColor: primaryColor ?? fsPrimaryColor,
                secondaryColor: secondaryColor ?? fsSecondaryColor,
                fileTypes: value.fileTypes,
                primaryTextStyle: primaryTextStyle ?? fsPrimaryTextStyle,
                secondaryTextStyle:
                    secondaryTextStyle ?? fsSecondaryTextStyle)),
        super(key: key);

  FileSaver.copyWith({Key? key, required FileSaver fileSaver})
      : headerBuilder = fileSaver.headerBuilder,
        bodyBuilder = fileSaver.bodyBuilder,
        footerBuilder = fileSaver.bodyBuilder,
        primaryColor = fileSaver.primaryColor,
        secondaryColor = fileSaver.secondaryColor,
        primaryTextStyle = fileSaver.primaryTextStyle,
        secondaryTextStyle = fileSaver.secondaryTextStyle,
        initialFileName = fileSaver.initialFileName,
        initialDirectory = fileSaver.initialDirectory,
        fileTypes = fileSaver.fileTypes,
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
            backgroundColor: secondaryColor,
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

extension SavePath on FileSaver {
  Future<String?> savePath(BuildContext context) => savefunction(context, this);
}
