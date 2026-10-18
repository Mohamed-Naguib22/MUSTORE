import 'package:equatable/equatable.dart';

class ChangePasswordParams extends Equatable {
  final String oldPasswordEncrypted;
  final String newPasswordEncrypted;

  const ChangePasswordParams({
    required this.oldPasswordEncrypted,
    required this.newPasswordEncrypted,
  });

  Map<String, dynamic> toJson() => {
    'oldPasswordEncrypted': oldPasswordEncrypted,
    'newPasswordEncrypted': newPasswordEncrypted,
  };

  @override
  List<Object?> get props => [
    oldPasswordEncrypted,
    newPasswordEncrypted,
  ];
}