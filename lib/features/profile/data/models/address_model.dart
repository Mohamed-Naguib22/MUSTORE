import 'package:mustore/features/profile/domain/entities/address.dart';

class AddressModel extends Address {
  const AddressModel({
    required super.id,
    required super.street,
    super.building,
    super.apartment,
    super.floor,
    super.additionalInfo,
    required super.postalCode,
    required super.isDefault,
    required super.city,
    required super.governorate,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'] as String,
      street: json['street'] as String,
      building: json['building'] as String?,
      apartment: json['apartment'] as String?,
      floor: json['floor'] as String?,
      additionalInfo: json['additionalInfo'] as String?,
      postalCode: json['postalCode'] as String,
      isDefault: json['isDefault'] as bool,
      city: json['city'] as String,
      governorate: json['governorate'] as String,
    );
  }
}