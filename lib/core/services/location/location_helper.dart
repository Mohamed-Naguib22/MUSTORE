import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mustore/core/services/permissions/permission_helper.dart';

abstract final class LocationHelper {
  static final Geocoding _geocoding = Geocoding();

  static Future<String?> currentLocationName() async {
    if (!await PermissionHelper.isGranted(AppPermission.location)) return null;
    if (!await Geolocator.isLocationServiceEnabled()) return null;

    try {
      final pos = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.low,
        ),
      );
      final marks = await _geocoding.placemarkFromCoordinates(
        pos.latitude,
        pos.longitude,
      );
      if (marks.isEmpty) return null;

      final p = marks.first;
      final parts = [p.locality, p.country]
          .whereType<String>()
          .where((e) => e.isNotEmpty);
      return parts.isEmpty ? null : parts.join(', ');
    } catch (_) {
      return null;
    }
  }
}