import 'package:mustore/features/profile/domain/entities/contact.dart';

class ContactModel extends Contact {
  const ContactModel({
    required super.id,
    required super.phoneNumber,
    required super.isPrimary,
    required super.isVerified,
  });

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      id: json['id'] as String,
      phoneNumber: json['phoneNumber'] as String,
      isPrimary: json['isPrimary'] as bool,
      isVerified: json['isVerified'] as bool,
    );
  }
}