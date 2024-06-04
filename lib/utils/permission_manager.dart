import 'package:permission_handler/permission_handler.dart';

class StoragePermissionHandler {
  static Future<bool> requestPermission() async {
    // Check the current permission status
    PermissionStatus status = await Permission.storage.status;

    // If the permission is already granted, return true
    if (status.isGranted) {
      return true;
    }

    // If the permission is denied, request it
    if (status.isDenied) {
      status = await Permission.storage.request();
    }

    // If the permission is permanently denied, open app settings
    if (status.isPermanentlyDenied) {
      await openAppSettings();
    }

    // Return true if the permission is granted, otherwise false
    return status.isGranted;
  }
}
