import 'package:permission_handler/permission_handler.dart';

enum AppPermission {
  notification(Permission.notification),
  location(Permission.locationWhenInUse);

  const AppPermission(this.permission);

  final Permission permission;
}

abstract final class PermissionHelper {
  static const List<AppPermission> _startup = [
    AppPermission.notification,
    AppPermission.location,
  ];

  static final Set<AppPermission> _inFlight = {};

  static bool isRequesting(AppPermission appPermission) =>
      _inFlight.contains(appPermission);

  static Future<Map<AppPermission, PermissionStatus>>
  requestStartupPermissions() async {
    final results = <AppPermission, PermissionStatus>{};
    for (final permission in _startup) {
      results[permission] = await request(permission);
    }
    return results;
  }

  static Future<PermissionStatus> request(AppPermission appPermission) async {
    final permission = appPermission.permission;
    final status = await permission.status;

    if (status.isGranted ||
        status.isLimited ||
        status.isPermanentlyDenied ||
        status.isRestricted) {
      return status;
    }

    if (!_inFlight.add(appPermission)) return status;

    try {
      return await permission.request();
    } finally {
      _inFlight.remove(appPermission);
    }
  }

  static Future<bool> isGranted(AppPermission appPermission) =>
      appPermission.permission.isGranted;

  static Future<bool> openSettings() => openAppSettings();
}