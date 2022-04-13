library filesaver;

import 'dart:io';
import '../widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'FileSaverState.dart';
import 'widgets/body.dart';
import 'widgets/footer.dart';

const Color fsPrimaryColor = Colors.blue;
const Color fsSecondaryColor = Colors.white;
const TextStyle fsPrimaryTextStyle =
    TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600);
const TextStyle fsSecondaryTextStyle =
    TextStyle(color: Colors.black87, fontWeight: FontWeight.bold);

///required [MediaQuery] widget ancestor
class FileSaver extends StatelessWidget {
  final Directory? initialDirectory;
  final PreferredSizeWidget? headerBuilder;
  final Widget? bodyBuilder, footerBuilder;
  final Color? primaryColor, secondaryColor;
  final TextStyle? primaryTextStyle, secondaryTextStyle;
  final String initialFileName;
  final List<String> initialFileExtension;

  FileSaver.builder(
      {Key? key,
      this.initialDirectory,
      required this.initialFileName,
      required this.initialFileExtension,
      PreferredSizeWidget? headerBuilder,
      Widget? bodyBuilder,
      Widget? footerBuilder,
      this.primaryColor,
      this.secondaryColor,
      this.primaryTextStyle,
      this.secondaryTextStyle})
      : headerBuilder = headerBuilder ??
            header(
                primaryColor: fsPrimaryColor,
                secondaryColor: fsSecondaryColor,
                primaryTextStyle: fsPrimaryTextStyle),
        bodyBuilder = bodyBuilder ??
            body(
                primaryColor: fsPrimaryColor,
                secondaryColor: fsSecondaryColor,
                secondaryTextStyle: fsSecondaryTextStyle),
        footerBuilder = footerBuilder ??
            footer(
                fileName: initialFileName,
                primaryColor: fsPrimaryColor,
                secondaryColor: fsSecondaryColor,
                fileExtension: initialFileExtension,
                primaryTextStyle: fsPrimaryTextStyle,
                secondaryTextStyle: fsSecondaryTextStyle),
        super(key: key);

  FileSaver(
      {Key? key,
      this.initialDirectory,
      required this.initialFileName,
      required this.initialFileExtension,
      this.primaryColor,
      this.secondaryColor,
      this.primaryTextStyle,
      this.secondaryTextStyle})
      : headerBuilder = header(
            primaryColor: fsPrimaryColor,
            secondaryColor: fsSecondaryColor,
            primaryTextStyle: fsPrimaryTextStyle),
        bodyBuilder = body(
            primaryColor: fsPrimaryColor,
            secondaryColor: fsSecondaryColor,
            secondaryTextStyle: fsSecondaryTextStyle),
        footerBuilder = footer(
            fileName: initialFileName,
            primaryColor: fsPrimaryColor,
            secondaryColor: fsSecondaryColor,
            fileExtension: initialFileExtension,
            primaryTextStyle: fsPrimaryTextStyle,
            secondaryTextStyle: fsSecondaryTextStyle),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FileSaverState(initialDirectory: initialDirectory),
      builder: (providerContext, providerChild) {
        Provider.of<FileSaverState>(providerContext, listen: false).initState();

        return Scaffold(
          backgroundColor: secondaryColor,
          appBar: headerBuilder,
          body: bodyBuilder,
          bottomSheet: footerBuilder,
        );
      },
    );
  }
}
