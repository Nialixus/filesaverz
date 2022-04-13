import 'dart:io';

import 'package:filesaver/FileSaver.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      title: 'File Saver Example',
      home: FileSaver(
        initialFileExtension: const ['.txt', '.pdf'],
        initialFileName: 'File Name',
      )));
}
