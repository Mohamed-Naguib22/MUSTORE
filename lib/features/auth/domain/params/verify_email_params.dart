import 'package:equatable/equatable.dart';

class VerifyEmailParams extends Equatable {
  final String email;
  final String encryptedOtp;

  const VerifyEmailParams({
    required this.email,
    required this.encryptedOtp,
  });

  Map<String, dynamic> toJson() => {
    'email': email,
    'encryptedOtp': encryptedOtp,
  };

  @override
  List<Object?> get props => [email, encryptedOtp];
}