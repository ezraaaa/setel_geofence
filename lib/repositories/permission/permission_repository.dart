import 'package:permission_handler/permission_handler.dart';

class PermissionRepository {
  Future<PermissionStatus> checkPermission(
      PermissionWithService permission) async {
    return await permission.status;
  }

  Future<PermissionStatus> requestPermission(PermissionWithService permission) async {
    return await Permission.contacts.request();
  }
}
