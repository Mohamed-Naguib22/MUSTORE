import 'package:equatable/equatable.dart';

class ForgetPasswordParams extends Equatable {
  final String email;

  const ForgetPasswordParams({
    required this.email,
  });

  Map<String, dynamic> toJson() => {
    'email': email,
  };

  @override
  List<Object?> get props => [email,];
}