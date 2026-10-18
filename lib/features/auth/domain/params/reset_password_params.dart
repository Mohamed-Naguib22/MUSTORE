import 'package:equatable/equatable.dart';

class ResetPasswordParams extends Equatable {
  final String email;
  final String encryptedOtp;
  final String mewPasswordEncrypted;

  const ResetPasswordParams({
    required this.email,
    required this.encryptedOtp,
    required this.mewPasswordEncrypted,
  });

  Map<String, dynamic> toJson() => {
    'email': email,
    'encryptedPassword': encryptedOtp,
    'mewPasswordEncrypted': mewPasswordEncrypted,
  };

  @override
  List<Object?> get props => [
    email,
    encryptedOtp,
    mewPasswordEncrypted,
  ];
}