import 'package:equatable/equatable.dart';

class ResetPasswordParams extends Equatable {
  final String email;
  final String encryptedOtp;
  final String newPasswordEncrypted;

  const ResetPasswordParams({
    required this.email,
    required this.encryptedOtp,
    required this.newPasswordEncrypted,
  });

  Map<String, dynamic> toJson() => {
    'email': email,
    'encryptedOtp': encryptedOtp,
    'newPasswordEncrypted': newPasswordEncrypted,
  };

  @override
  List<Object?> get props => [
    email,
    encryptedOtp,
    newPasswordEncrypted,
  ];
}