import 'package:equatable/equatable.dart';
import 'package:mustore/features/profile/domain/enums/gender.dart';

class UpdateProfileParams extends Equatable {
  const UpdateProfileParams({
    this.firstName,
    this.lastName,
    this.gender,
  });

  final String? firstName;
  final String? lastName;
  final Gender? gender;

  bool get isEmpty => firstName == null && lastName == null && gender == null;

  Map<String, dynamic> toJson() => {
    if (firstName != null) 'firstName': firstName,
    if (lastName != null) 'lastName': lastName,
    if (gender != null) 'gender': gender!.toJson(),
  };

  @override
  List<Object?> get props => [firstName, lastName, gender];
}