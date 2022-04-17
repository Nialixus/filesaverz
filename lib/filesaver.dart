library filesaver;

import 'dart:io';
import 'widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'filesaverstate.dart';
import 'widgets/body.dart';
import 'widgets/footer.dart';
import 'package:permission_handler/permission_handler.dart';

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
  final List<String> fileExtensions;

  FileSaver.builder(
      {Key? key,
      required this.initialFileName,
      required this.fileExtensions,
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
  Widget build(BuildContext context) => Scaffold(
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

  static Future<String?> output(BuildContext context, FileSaver fileSaver,
      Directory? initialDirectory) async {
    Permission storage = Permission.storage;
    await storage.request();
    PermissionStatus permissionStatus = await storage.status;
    if (permissionStatus.isDenied) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Storage Access Denied'),
        backgroundColor: Colors.red,
      ));
      return null;
    } else {
      return showDialog<String>(
          context: context,
          barrierColor: Colors.transparent,
          builder: (context) => ChangeNotifierProvider(
              create: (c) => FileSaverState(initialDirectory: initialDirectory),
              builder: (providerContext, providerChild) {
                Provider.of<FileSaverState>(providerContext, listen: false)
                    .initState();

                return Consumer<FileSaverState>(
                    builder: (context, value, child) => WillPopScope(
                        onWillPop: () async {
                          Navigator.pop(context, value.output);
                          return true;
                        },
                        child: child!),
                    child: TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0, end: 1),
                        duration: const Duration(milliseconds: 300),
                        builder: (context, value, child) =>
                            FractionalTranslation(
                                translation: Offset(0, 1 - value),
                                child: fileSaver)));
              }));
    }
  }
}
