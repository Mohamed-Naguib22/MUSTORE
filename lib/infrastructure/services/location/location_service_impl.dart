import 'package:dartz/dartz.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mustore/core/error/exceptions.dart';
import 'package:mustore/core/error/failure.dart';
import 'package:mustore/core/services/location/location_service.dart';
import 'package:mustore/core/services/permissions/permission_helper.dart';

class LocationServiceImpl implements LocationService {
  LocationServiceImpl({Geocoding? geocoding})
      : _geocoding = geocoding ?? Geocoding();

  final Geocoding _geocoding;

  @override
  Future<Either<Failure, String>> currentLocationName() async {
    try {
      if (!await PermissionHelper.isGranted(AppPermission.location)) {
        throw const NoDataFoundException();
      }
      if (!await Geolocator.isLocationServiceEnabled()) {
        throw const NoDataFoundException();
      }

      final pos = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.low,
        ),
      );
      final marks = await _geocoding.placemarkFromCoordinates(
        pos.latitude,
        pos.longitude,
      );
      if (marks.isEmpty) throw const NoDataFoundException();

      final p = marks.first;
      final parts = [p.locality, p.country]
          .whereType<String>()
          .where((e) => e.isNotEmpty);
      if (parts.isEmpty) throw const NoDataFoundException();

      return Right(parts.join(', '));
    } on NoDataFoundException {
      return const Left(NoDataFailure());
    } catch (_) {
      return const Left(UnknownFailure());
    }
  }
}