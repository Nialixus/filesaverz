import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../filesaver.dart';
import '../../filepicker.dart';

export '../addons/filebrowser.dart' hide filebrowser;

/// Opening a custom file explorer.
Future<String?> filebrowser(BuildContext context,
    {FileSaver? fileSaver, FilePicker? filePicker}) async {
  Permission storage = Permission.storage;
  await storage.request();
  PermissionStatus permissionStatus = await storage.status;

  if (permissionStatus.isDenied) {
    /// If user not giving the app permission, it will showing snackbar and returning null.
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Storage Access Denied'),
        backgroundColor: Colors.red,
      ),
    );
    return null;
  } else {
    /// If app have permission, it will opening a custom file expolorer of [FileSaver].
    return showDialog<String>(
      context: context,
      barrierColor: Colors.transparent,
      builder: (context) => WillPopScope(
        onWillPop: () async {
          Navigator.pop(context, null);
          return true;
        },
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: 1),
          duration: const Duration(milliseconds: 300),
          builder: (context, value, child) => FractionalTranslation(
              translation: Offset(0, 1 - value),
              child: fileSaver ?? filePicker),
        ),
      ),
    );
  }
}
