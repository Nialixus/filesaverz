# File Saver Z
[![FileSaverZ Version](https://img.shields.io/pub/v/filesaverz.svg?logo=flutter&color=blue&style=flat-square)](https://pub.dev/packages/filesaverz)\
A package that makes it easy for user to browse folder and save file or pick files in android.

## Preview
|<img src='https://user-images.githubusercontent.com/45191605/164154922-7f470dbf-fd24-48d5-839e-11adb4574c40.gif' width=300/>|<img src='https://user-images.githubusercontent.com/45191605/164155033-6f16ebe1-eb9f-4960-b605-850f94f9b3da.png' width=300/>|
|---|---|
  
## Install
Add this to your dependency
```yaml
dependencies:
  filesaverz: ^1.6.0
```

Continue by adding permission in your `AndroidManifest.xml`.
```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.example.example">
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
    <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
```

And then import the filesaver (with z) package.
```dart
import 'package:filesaverz/filesaver.dart';
```
## FileSaver Usage
First, setting up the FileSaver widget like this.
```dart
  /// This is default FileSaver for saving file.
  FileSaver fileSaver = FileSaver(
  fileTypes: const ['txt','pdf'],
  initialFileName: 'Untitled File',
);
```
or this customable FileSaver.
```dart
FileSaver fileSaver = FileSaver.builder(
   fileTypes: const ['txt','pdf'],
   initialFileName: 'Untitled File',

   headerBuilder: (context,state)=> /* Your Widget */,
   bodyBuilder: (context,state)=> /* Your Widget */,
   footerBuilder: (context,state)=> /* Your Widget */,
);
```

And then in async function call these:

<table>
  <tr>
    <td><b>Purpose</b></td>
    <td><b>Code</b></td>
  </tr>
  <tr>
    <td>Getting selected path from saving file.</td>
    <td>
      <pre lang='dart'>String? path = await fileSaver.getPath(context);</pre>
    </td>
  </tr>
  <tr>
    <td>Calling <a href="https://api.flutter.dev/flutter/dart-io/File/writeAsBytes.html">writeAsBytes</a> method.</td>
    <td>
      <pre lang='dart'>fileSaver.writeAsBytes(bytes, context: context);</pre>
    </td>
  </tr>
  <tr>
    <td>Calling <a href="https://api.flutter.dev/flutter/dart-io/File/writeAsBytesSync.html">writeAsBytesSync</a> method.</td>
    <td>
      <pre lang='dart'>fileSaver.writeAsBytesSync(bytes, context: context);</pre>
    </td>
  </tr>
  <tr>
    <td>Calling <a href="https://api.flutter.dev/flutter/dart-io/File/writeAsString.html">writeAsString</a> method.</td>
    <td>
      <pre lang='dart'>fileSaver.writeAsString(contents, context: context);</pre>
    </td>
  </tr>
  <tr>
    <td>Calling <a href="https://api.flutter.dev/flutter/dart-io/File/writeAsStringSync.html">writeAsStringSync</a> method.</td>
    <td>
      <pre lang='dart'>fileSaver.writeAsStringSync(contents, context: context);</pre>
    </td>
  </tr>
</table>

## FilePicker Usage
  
Setting up the FilePicker like this.
``` dart
/// This is default FilePicker for picking file or files.
final filePicker = FileSaver.picker(
   fileTypes: const ['jpg','gif'],
);
```
<table>
  <tr>
    <td><b>Purpose</b></td>
    <td><b>Code</b></td>
  </tr>
  <tr>
    <td>Picking single file.</td>
    <td>
      <pre lang='dart'>File? file = await filePicker.getFile(context);</pre>
    </td>
  </tr>
  <tr>
    <td>Picking multiple files.</td>
    <td>
      <pre lang='dart'>List&ltFile&gt? files = await filePicker.getFiles(context);</pre>
    </td>
  </tr>
</table>

## Documentation
Full Documentation [here](https://pub.dev/documentation/filesaverz/latest/filesaverz/filesaverz-library.html).

## Example
* [filesaverz/example/lib/main.dart](https://github.com/Nialixus/filesaverz/blob/master/example/lib/main.dart)
<br>
