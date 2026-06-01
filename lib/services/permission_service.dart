import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  static Future<bool> requestPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.photos,
    ].request();

    return statuses[Permission.camera]!.isGranted && 
           statuses[Permission.photos]!.isGranted;
  }
}