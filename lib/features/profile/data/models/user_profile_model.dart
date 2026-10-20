import 'package:mustore/features/profile/domain/entities/user_profile.dart';
import 'package:mustore/features/profile/domain/enums/gender.dart';

class UserProfileModel extends UserProfile {
  const UserProfileModel({
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.gender,
    super.profilePictureUrl,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      profilePictureUrl: json['profilePictureUrl'] as String?,
      gender: Gender.fromJson(json['gender'] as String),
    );
  }
}