<p align='center'>
<img src='https://user-images.githubusercontent.com/45191605/272838580-8ed4093a-fb0b-4e2b-85ce-c2c905e2936f.png' width=200 /><br>
<a href='https://pub.dev/packages/filesaverz'><img src='https://img.shields.io/pub/v/filesaverz.svg?logo=flutter&color=blue&style=flat-square'/></a></p>

# File Saver Z

A customable file saver and file picker package that makes it easy for user to browse folder and save file or pick files in android.

## Preview

![screen-capture (1)](https://user-images.githubusercontent.com/45191605/167116228-6cbddb50-d98a-44d3-af1f-ce2b61ae8464.gif)

## Install

Add this to your `pubspec.yaml`.

```yaml
dependencies:
  filesaverz: ^3.2.1
```

Continue by adding permission in your `AndroidManifest.xml`.

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.example.example">
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
    <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
```

Just in case if you got `MissingPluginException(No implementation found for method checkPermissionStatus on channel flutter.baseflow.com/permissions/methods)` error, try fix it by adding this to your `app/build.gradle`.

```gradle
buildTypes {
       release {
           shrinkResources false
           minifyEnabled false
           signingConfig signingConfigs.release
       }
   }
```

And then import the filesaver (with z) package.

```dart
import 'package:filesaverz/filesaverz.dart';
```

## Usage

First, setting up the FileSaver widget like this.

```dart
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
   headerBuilder: (context, state) => /* Your Widget */,
   bodyBuilder: (context, state) => /* Your Widget */,
   footerBuilder: (context, state) => /* Your Widget */,
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
  <tr>
    <td>Picking single file.</td>
    <td>
      <pre lang='dart'>File? file = await fileSaver.pickFile(context);</pre>
    </td>
  </tr>
  <tr>
    <td>Picking multiple files.</td>
    <td>
      <pre lang='dart'>List&ltFile&gt? files = await fileSaver.pickFiles(context);</pre>
    </td>
  </tr>
</table>

## Documentation

<table>
  <tr>
    <td><b>Property</b></td>
    <td><b>Code</b></td>
  </tr>
  <tr>
    <td><b>headerBuilder</b>, an optional builder.</td>
    <td>
      <pre lang='dart'>
(context, state) {
  return Text('My Custom Header Widget');
},
      </pre>
    </td>
  </tr>
  <tr>
    <td><b>bodyBuilder</b>, an optional builder.</td>
    <td>
      <pre lang='dart'>
(context, state) {
  return Text('My Custom Body Widget');
},
      </pre>
    </td>
  </tr>
  <tr>
    <td><b>footerBuilder</b>, an optional builder</td>
    <td>
      <pre lang='dart'>
(context, state) {
  return Text('My Custom Footer Widget');
},
      </pre>
    </td>
  </tr>
  <tr>
    <td><b>style</b>, set custom <i>Color</i>, <i>TextStyle</i>, <i>Icon</i> and displayed <i>Text</i>.</td>
    <td>
      <pre lang='dart'>
FileSaverStyle(
  primaryColor: Colors.blue,
  secondaryColor: Colors.white,
  primaryTextStyle: TextStyle(),
  secondaryTextStyle: TextStyle(),
  icons: [
    FileSaverIcon(icon: (path) => Icon(Icons.default)),
    FileSaverIcon.directory(icon: (path) => Icon(Icons.folder)),
    FileSaverIcon.file(fileType: 'jpg', icon: (path) => Image.file(File(path)),
    ],
  text: FileSaverText(
    popupNo: 'Nay',
    popupYes: 'Sí',
  ),
),
      </pre>
    </td>
  </tr>
  <tr>
    <td><b>initialFileName</b>, this property is used when you call saving method.</td>
    <td>
      <pre lang='dart'>
'Untitled File',
      </pre>
    </td>
  </tr>
  <tr>
    <td><b>initialDirectory</b>, in Android by default it's calling <a href='https://developer.android.com/reference/android/os/Environment#getExternalStorageDirectory()'>Environment.getExternalStorageDirectory</a>.</td>
    <td>
      <pre lang='dart'>
Directory('Storage Path'),
      </pre>
    </td>
  </tr>
  <tr>
    <td><b>fileTypes</b>, this property is used to limit what kind of fileTypes that we want to display, and in saving method this fileTypes also used as an option for user to set the desired fileTypes to write.</td>
    <td>
      <pre lang='dart'>
const ['jpg','gif','png'],
      </pre>
    </td>
  </tr>
</table>

Full Documentation [here](https://pub.dev/documentation/filesaverz/latest/filesaverz/filesaverz-library.html).

## Example

- [filesaverz/example/lib/main.dart](https://github.com/Nialixus/filesaverz/blob/master/example/lib/main.dart)
