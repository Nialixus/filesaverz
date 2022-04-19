import 'dart:io';

import 'package:filesaver/filesaver.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
      title: 'File Saver Example',
      debugShowCheckedModeBanner: false,
      home: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Material(
          color: Colors.blue,
          child: InkWell(
              onTap: () async {
                String? result = await FileSaver(
                        initialFileName: 'File Name',
                        fileTypes: const ['txt', '.pdf', '.rtf'])
                    .getString(context);

                print(result);
              },
              child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Browse',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ))),
        ),
      ),
    );
  }
}
