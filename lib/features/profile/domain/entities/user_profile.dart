import 'package:equatable/equatable.dart';
import 'package:mustore/features/profile/domain/enums/gender.dart';

class UserProfile extends Equatable {
  const UserProfile({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.gender,
    this.profilePictureUrl,
  });

  final String firstName;
  final String lastName;
  final String email;
  final String? profilePictureUrl;
  final Gender gender;

  String get fullName => '$firstName $lastName';

  @override
  List<Object?> get props => [
    firstName,
    lastName,
    email,
    profilePictureUrl,
    gender,
  ];
}