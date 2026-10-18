import 'package:equatable/equatable.dart';

class ResendOtpParams extends Equatable {
  final String email;

  const ResendOtpParams({
    required this.email,
  });

  Map<String, dynamic> toJson() => {
    'email': email,
  };

  @override
  List<Object?> get props => [email,];
}