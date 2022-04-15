import 'package:filesaver/filesaver.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
      title: 'File Saver Example',
      home: FileSaver(
        fileExtensions: const ['.txt', '.pdf'],
        initialFileName: 'File Name',
      )));
}
