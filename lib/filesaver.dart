import 'dart:io';
import '../FileSaverState.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'FileSaverStyle.dart';
import 'FileSaverWidget.dart';

class FileSaver extends StatelessWidget {
  final Directory? initialDirectory;
  final PreferredSizeWidget? headerBuilder;
  final Widget? bodyBuilder, footerBuilder;
  final Color? primaryColor, secondaryColor;
  final TextStyle? primaryTextStyle, secondaryTextStyle;

  FileSaver.builder({
    Key? key,
    this.initialDirectory,
    PreferredSizeWidget? headerBuilder,
    Widget? bodyBuilder,
    Widget? footerBuilder,
  })  : headerBuilder = headerBuilder ??
            FileSaverWidget.header(
                primaryColor: FileSaverStyle.primaryColor,
                secondaryColor: FileSaverStyle.secondaryColor,
                primaryTextStyle: FileSaverStyle.primaryTextStyle),
        bodyBuilder = bodyBuilder ??
            FileSaverWidget.body(
                primaryColor: FileSaverStyle.primaryColor,
                secondaryColor: FileSaverStyle.secondaryColor,
                secondaryTextStyle: FileSaverStyle.secondaryTextStyle),
        footerBuilder = footerBuilder ??
            FileSaverWidget.footer(
                primaryColor: FileSaverStyle.primaryColor,
                secondaryColor: FileSaverStyle.secondaryColor,
                secondaryTextStyle: FileSaverStyle.secondaryTextStyle),
        primaryColor = FileSaverStyle.primaryColor,
        secondaryColor = FileSaverStyle.secondaryColor,
        primaryTextStyle = FileSaverStyle.primaryTextStyle,
        secondaryTextStyle = FileSaverStyle.secondaryTextStyle,
        super(key: key);

  FileSaver(
      {Key? key,
      this.initialDirectory,
      this.primaryColor,
      this.secondaryColor,
      this.primaryTextStyle,
      this.secondaryTextStyle})
      : headerBuilder = FileSaverWidget.header(
            primaryColor: FileSaverStyle.primaryColor,
            secondaryColor: FileSaverStyle.secondaryColor,
            primaryTextStyle: FileSaverStyle.primaryTextStyle),
        bodyBuilder = FileSaverWidget.body(
            primaryColor: FileSaverStyle.primaryColor,
            secondaryColor: FileSaverStyle.secondaryColor,
            secondaryTextStyle: FileSaverStyle.secondaryTextStyle),
        footerBuilder = FileSaverWidget.footer(
            primaryColor: FileSaverStyle.primaryColor,
            secondaryColor: FileSaverStyle.secondaryColor,
            secondaryTextStyle: FileSaverStyle.secondaryTextStyle),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FileSaverState(),
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
