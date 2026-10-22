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
    );
  }

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
  ];
}