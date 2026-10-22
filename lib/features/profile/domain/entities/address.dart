import 'package:equatable/equatable.dart';

class Address extends Equatable {
  final String id;
  final String street;
  final String? building;
  final String? apartment;
  final String? floor;
  final String? additionalInfo;
  final String postalCode;
  final bool isDefault;
  final String city;
  final String governorate;
  final String cityId;
  final String governorateId;
  final String countryId;

  const Address({
    required this.id,
    required this.street,
    this.building,
    this.apartment,
    this.floor,
    this.additionalInfo,
    required this.postalCode,
    required this.isDefault,
    required this.city,
    required this.governorate,
    required this.cityId,
    required this.governorateId,
    required this.countryId,
  });

  factory Address.fake({
    String id = '3fa85f64-5717-4562-b3fc-2c963f66afa6',
    String street = '26th of July Corridor',
    String? building = '12',
    String? apartment = '5',
    String? floor = '3',
    String? additionalInfo = 'Next to the main gate',
    String postalCode = '12511',
    bool isDefault = false,
    String city = '6th of October',
    String governorate = 'Giza',
    String cityId = '3fa85f64-5717-4562-b3fc-2c963f66afa6',
    String governorateId = '3fa85f64-5717-4562-b3fc-2c963f66afa6',
    String countryId = '3fa85f64-5717-4562-b3fc-2c963f66afa6',
  }) {
    return Address(
      id: id,
      street: street,
      building: building,
      apartment: apartment,
      floor: floor,
      additionalInfo: additionalInfo,
      postalCode: postalCode,
      isDefault: isDefault,
      city: city,
      governorate: governorate,
      cityId: cityId,
      governorateId: governorateId,
      countryId: countryId,
    );
  }

  Address copyWith({
    String? id,
    String? street,
    String? building,
    String? apartment,
    String? floor,
    String? additionalInfo,
    String? postalCode,
    bool? isDefault,
    String? city,
    String? governorate,
    String? cityId,
    String? governorateId,
    String? countryId,
  }) =>
      Address(
        id: id ?? this.id,
        street: street ?? this.street,
        building: building ?? this.building,
        apartment: apartment ?? this.apartment,
        floor: floor ?? this.floor,
        additionalInfo: additionalInfo ?? this.additionalInfo,
        postalCode: postalCode ?? this.postalCode,
        isDefault: isDefault ?? this.isDefault,
        city: city ?? this.city,
        governorate: governorate ?? this.governorate,
        cityId: cityId ?? this.cityId,
        governorateId: governorateId ?? this.governorateId,
        countryId: countryId ?? this.countryId,
      );

  @override
  List<Object?> get props => [
    id,
    street,
    building,
    apartment,
    floor,
    additionalInfo,
    postalCode,
    isDefault,
    city,
    governorate,
    cityId,
    governorateId,
    countryId,
  ];
}