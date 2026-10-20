import 'package:equatable/equatable.dart';
import 'package:mustore/features/profile/domain/enums/gender.dart';

class UserProfile extends Equatable {
  const UserProfile({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.gender,
    required this.profilePictureUrl,
  });

  const UserProfile.fake()
      : firstName = 'Mohamed',
        lastName = 'Naguib',
        email = 'placeholder@mustore.com',
        profilePictureUrl = '',
        gender = Gender.male;

  static const String defaultPictureFileName = 'Default_Picture.png';

  final String firstName;
  final String lastName;
  final String email;
  final String profilePictureUrl;
  final Gender gender;

  String get fullName => '$firstName $lastName';

  bool get isDefaultPicture =>
      profilePictureUrl.isEmpty ||
          profilePictureUrl.toLowerCase().contains(defaultPictureFileName.toLowerCase());

  @override
  List<Object?> get props => [
    firstName,
    lastName,
    email,
    profilePictureUrl,
    gender,
  ];
}