import 'package:equatable/equatable.dart';

class UpdateAddressParams extends Equatable {
  const UpdateAddressParams({
    required this.id,
    this.street,
    this.building,
    this.apartment,
    this.postalCode,
    this.cityId,
  });

  final String id;
  final String? street;
  final String? building;
  final String? apartment;
  final String? postalCode;
  final String? cityId;

  bool get isEmpty =>
      street == null &&
          building == null &&
          apartment == null &&
          postalCode == null &&
          cityId == null;

  Map<String, dynamic> toJson() => {
    'street': street,
    'building': building,
    'apartment': apartment,
    'postalCode': postalCode,
    'cityId': cityId,
  };

  @override
  List<Object?> get props => [
    id,
    street,
    building,
    apartment,
    postalCode,
    cityId,
  ];
}