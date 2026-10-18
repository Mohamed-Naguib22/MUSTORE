import 'package:equatable/equatable.dart';

class LoginParams extends Equatable {
  final String email;
  final String encryptedPassword;

  const LoginParams({
    required this.email,
    required this.encryptedPassword,
  });

  Map<String, dynamic> toJson() => {
    'email': email,
    'encryptedPassword': encryptedPassword,
  };

  @override
  List<Object?> get props => [email, encryptedPassword];
}