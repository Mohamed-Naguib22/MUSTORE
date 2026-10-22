import 'package:equatable/equatable.dart';

class AddAddressParams extends Equatable {
  const AddAddressParams({
    required this.street,
    this.building,
    this.apartment,
    this.floor,
    this.additionalInfo,
    required this.postalCode,
    this.isDefault = false,
    required this.cityId,
  });

  final String street;
  final String? building;
  final String? apartment;
  final String? floor;
  final String? additionalInfo;
  final String postalCode;
  final bool isDefault;
  final String cityId;

  Map<String, dynamic> toJson() => {
    'street': street,
    'building': building,
    'apartment': apartment,
    'floor': floor,
    'additionalInfo': additionalInfo,
    'postalCode': postalCode,
    'isDefault': isDefault,
    'cityId': cityId,
  };

  @override
  List<Object?> get props => [
    street,
    building,
    apartment,
    floor,
    additionalInfo,
    postalCode,
    isDefault,
    cityId,
  ];
}