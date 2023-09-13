import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '/filesaverz.dart';

export '../addons/filebrowser.dart' hide filebrowser;

/// Opening a custom file explorer.
Future<String?> filebrowser(BuildContext context, FileSaver fileSaver) async {
  Permission storage = Permission.storage;
  await storage.request();
  PermissionStatus permissionStatus = await storage.status;
  //Android 13 or high
  Permission photos = Permission.photos;
  await photos.request();
  PermissionStatus permissionStatusPhotos = await photos.status;
  
  if (permissionStatus.isGranted || permissionStatusPhotos.isGranted) {
    /// If app have permission, it will opening a custom file expolorer of [FileSaver].
    return showDialog<String>(
      context: context,
      barrierColor: Colors.transparent,
      builder: (context) => TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: 1),
        duration: const Duration(milliseconds: 300),
        builder: (context, value, child) => FractionalTranslation(
            translation: Offset(0, 1 - value), child: fileSaver),
      ),
    );
  } else {
    /// If user not giving the app permission, it will showing snackbar and returning null.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          fileSaver.style!.text.messageDenied,
          style: fileSaver.style!.primaryTextStyle.copyWith(
              fontSize: fileSaver.style!.secondaryTextStyle.fontSize ?? 14),
        ),
        backgroundColor: Colors.red,
      ),
    );
    return null;
  }
}
