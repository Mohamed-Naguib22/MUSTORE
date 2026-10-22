import 'package:equatable/equatable.dart';

class Contact extends Equatable {
  final String id;
  final String phoneNumber;
  final bool isVerified;
  final bool isPrimary;

  const Contact({
    required this.id,
    required this.phoneNumber,
    required this.isVerified,
    required this.isPrimary,
  });

  factory Contact.fake({
    String id = '3fa85f64-5717-4562-b3fc-2c963f66afa6',
    String phoneNumber = '0106083521',
    bool isVerified = true,
    bool isPrimary = false,
  }) {
    return Contact(
      id: id,
      phoneNumber: phoneNumber,
      isVerified: isVerified,
      isPrimary: isPrimary,
    );
  }

  Contact copyWith({
    String? id,
    String? phoneNumber,
    bool? isVerified,
    bool? isPrimary,
  }) =>
      Contact(
        id: id ?? this.id,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        isVerified: isVerified ?? this.isVerified,
        isPrimary: isPrimary ?? this.isPrimary,
      );

  @override
  List<Object?> get props => [
    id,
    phoneNumber,
    isVerified,
    isPrimary,
  ];
}