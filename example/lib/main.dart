import 'dart:developer';
import 'dart:io';

import 'package:filesaverz/filesaverz.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    title: 'File Saver Example',
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

/// Homepage.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    /// Setting up file explorer.
    FileSaver fileSaver = FileSaver(
      initialFileName: 'New File',
      fileTypes: const ['txt'],
    );

    return Scaffold(
      body: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          /// Save File.
          MyButton(
            text: 'Save File',
            icon: Icons.save,
            onTap: () {
              fileSaver.writeAsString('Hello World', context: context);
            },
          ),

          /// Pick File.
          MyButton(
            text: 'Pick File',
            icon: Icons.insert_drive_file_rounded,
            onTap: () async {
              File? file = await fileSaver.pickFile(context);
              log(file.toString());
            },
          ),

          /// Pick Multiple Files.
          MyButton(
            text: 'Pick Files',
            icon: Icons.file_copy,
            onTap: () async {
              List<File>? files = await fileSaver.pickFiles(context);
              log(files.toString());
            },
          ),
        ]),
      ),
    );
  }
}

/// Custom button.
class MyButton extends StatelessWidget {
  const MyButton(
      {Key? key,
      required this.text,
      required this.icon,
      this.onTap})
      : super(key: key);

  final String text;
  final IconData icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Material(
        color: Colors.blue,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: Colors.white),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
