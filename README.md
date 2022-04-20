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
And set fileSaver widget like this.
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
Use this to call `File(path).writeAsBytes(bytes)` function.
```dart
fileSaver.writeAsBytes(bytes, context: context);
```
\
Use this to call `File(path).writeAsBytesSync(bytes)` function.
```dart
fileSaver.writeAsBytesSync(bytes, context: context);
```
\
Use this to call `File(path).writeAsString(contents)` function.
```dart
fileSaver.writeAsString(contents, context: context);
```
\
Use this to call `File(path).writeAsStringSync(contents)` function.
```dart
fileSaver.writeAsStringSync(contents, context: context);
```


## Documentation
* Widget? `headerBuilder` :\
 Is an optional header widget. Default widget only shows title and close button.
  ```dart
  headerBuilder: (context, state) => Widget(),
  ```

* Widget? `bodyBuilder` :\
 Is an optional widget as well. By Default displaying list of `FileSystemEntity`.
  ```dart
  bodyBuilder: (context, state) => Widget(),
  ```
  
* Widget? `footerBuilder` :\
Is also an optional widget. It's displaying option to input new file name and select file types.
  ```dart
  footerBuilder: (context, state) => Widget(),
  ```

* FileSaverStyle? `style` :\
 A custom style in `FileSaver`. It contains colors and textstyles.
  ```dart
  style: FileSaverStyle(primaryColor: Colors.orange);
  ```

* String `initialFileName` :\
 Is a file name. If user enters new name, this will be replaced.
  ```dart
  initialFileName: 'New File';
  ```

* Director? `initialDirectory` :\
 Is an optional directory. If initialDirectory is null, in android it will call a method channel of `Environment.getExternalStorageDirectory()`.
 
* List&lt;String&gt; `fileTypes` :\
  Displaying list of file extensions.
  ```dart
  fileTypes: const ['.txt','.pdf','.rtf'];
  ```

## Example
* <a href="https://github.com/Nialixus/filesaver/blob/master/example/lib/main.dart">filesaver/example/lib/main.dart</a>
