# File Saver Z
<a href='https://pub.dev/packages/filesaverz'><img src='https://img.shields.io/pub/v/filesaverz.svg?logo=flutter&color=blue&style=flat-square'/></a>
\
\
A package that makes it easy for user to browse folder and save file in android.

## Preview
<table><tr><td>
  <img src='https://user-images.githubusercontent.com/45191605/164154922-7f470dbf-fd24-48d5-839e-11adb4574c40.gif' width='300'/>  
  </td><td>
  <img src='https://user-images.githubusercontent.com/45191605/164155033-6f16ebe1-eb9f-4960-b605-850f94f9b3da.png' width='300'/>
  </td></tr></table>
  
## Install
Add this to your dependency
```yaml
dependencies:
  filesaverz: ^1.2.0
```
## Usage
First, add permission in your `AndroidManifest.xml`.
```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.example.example">
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
    <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
```
\
And then import the filesaver (with z) package.
```dart
import 'package:filesaverz/filesaver.dart';
```
\
And set filesaver widget like this.
```dart
FileSaver fileSaver = FileSaver(
  initialFileName: 'New File',
  fileTypes: const ['.txt','.pdf'],
);
```
\
Now in async function, call this to getPath.
```dart
String? path = await fileSaver.getPath(context);
```
\
Use this to call <a href="https://api.flutter.dev/flutter/dart-io/File/writeAsBytes.html">File(path).writeAsBytes(bytes)</a> function.
```dart
fileSaver.writeAsBytes(bytes, context: context);
```
\
Use this to call <a href="https://api.flutter.dev/flutter/dart-io/File/writeAsBytesSync.html">File(path).writeAsBytesSync(bytes)</a> function.
```dart
fileSaver.writeAsBytesSync(bytes, context: context);
```
\
Use this to call <a href="https://api.flutter.dev/flutter/dart-io/File/writeAsString.html">File(path).writeAsString(contents)</a> function.
```dart
fileSaver.writeAsString(contents, context: context);
```
\
Use this to call <a href ="https://api.flutter.dev/flutter/dart-io/File/writeAsStringSync.html">File(path).writeAsStringSync(contents)</a> function.
```dart
fileSaver.writeAsStringSync(contents, context: context);
```


## Documentation
`headerBuilder`, is an optional header widget. Default widget only shows title and close button.
  ```dart
  headerBuilder: (context, state) => Widget(),
  ```
\
`bodyBuilder`, is an optional widget as well. By Default displaying list of `FileSystemEntity`.
  ```dart
  bodyBuilder: (context, state) => Widget(),
  ```
\
`footerBuilder`, is also an optional widget. It's displaying option to input new file name and select file types.
  ```dart
  footerBuilder: (context, state) => Widget(),
  ```
\
`style`, is a custom style in `FileSaver`. It contains colors and textstyles.
  ```dart
  style: FileSaverStyle(primaryColor: Colors.orange);
  ```
\
`initialFileName`, is set as default file name. If user enters new name in textfield, this will be replaced.
  ```dart
  initialFileName: 'New File';
  ```
\
`initialDirectory`, is an optional directory. If initialDirectory is null, in android it will call a method channel of <a href="https://developer.android.com/reference/android/os/Environment#getExternalStorageDirectory()">Environment.getExternalStorageDirectory()</a>.
\
`fileTypes`, displaying list of file extensions.
  ```dart
  fileTypes: const ['.txt','.pdf','.rtf'];
  ```

* Full Documentation <a href='https://pub.dev/documentation/filesaverz/latest/filesaverz/filesaverz-library.html'>here</a>.
## Example
* <a href="https://github.com/Nialixus/filesaverz/blob/master/example/lib/main.dart">filesaverz/example/lib/main.dart</a>
