import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '../filesaver.dart';

Future<String?> result(BuildContext context, FileSaver fileSaver) async {
  Permission storage = Permission.storage;
  await storage.request();
  PermissionStatus permissionStatus = await storage.status;

  if (permissionStatus.isDenied) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Storage Access Denied'),
        backgroundColor: Colors.red,
      ),
    );
    return null;
  } else {
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
              translation: Offset(0, 1 - value), child: fileSaver),
        ),
      ),
    );
  }
}
