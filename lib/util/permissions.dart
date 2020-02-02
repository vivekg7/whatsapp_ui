import 'package:permission_handler/permission_handler.dart';

class Permissions {
  Future checkAndGetPermissions({bool camera = false, bool contacts = false}) async {
    PermissionStatus p;
    if (camera) {
      p = await PermissionHandler().checkPermissionStatus(PermissionGroup.camera);
      if (p != PermissionStatus.granted) {
        Map<PermissionGroup, PermissionStatus> ps = await PermissionHandler().requestPermissions([PermissionGroup.camera]);
        if (ps["PermissionGroup.camera"] != PermissionStatus.granted) return false;
      }
    }
    if (contacts) {
      p = await PermissionHandler().checkPermissionStatus(PermissionGroup.contacts);
      if (p != PermissionStatus.granted) {
        Map<PermissionGroup, PermissionStatus> ps = await PermissionHandler().requestPermissions([PermissionGroup.contacts]);
        if (ps["PermissionGroup.contacts"] != PermissionStatus.granted) return false;
      }
    }
    return true;
  }
}