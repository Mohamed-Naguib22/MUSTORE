import 'package:equatable/equatable.dart';
import 'package:mustore/features/profile/domain/enums/gender.dart';

class RegisterParams extends Equatable {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String email;
  final String encryptedPassword;
  final Gender gender;

  const RegisterParams({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
    required this.encryptedPassword,
    required this.gender,
  });

  Map<String, dynamic> toJson() => {
    'firstName': firstName,
    'lastName': lastName,
    'phoneNumber': phoneNumber,
    'email': email,
    'encryptedPassword': encryptedPassword,
    'gender': gender.value,
  };

  @override
  List<Object?> get props => [
    firstName,
    lastName,
    phoneNumber,
    email,
    encryptedPassword,
    gender,
  ];
}