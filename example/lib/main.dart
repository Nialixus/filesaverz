import 'package:filesaver/filesaver.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(title: 'File Saver Example', home: Home()));
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Material(
          color: Colors.blue,
          child: InkWell(
              onTap: () => showFileSaver(
                  context,
                  FileSaver(
                      initialFileName: 'File Name',
                      fileExtensions: const ['txt', 'pdf'])),
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
