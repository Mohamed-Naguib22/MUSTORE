import 'package:equatable/equatable.dart';

class VerifyContactParams extends Equatable {
  const VerifyContactParams({
    required this.contactId,
    required this.encryptedOtp,
  });

  final String contactId;
  final String encryptedOtp;

  Map<String, dynamic> toJson() => {
    'contactId': contactId,
    'encryptedOtp': encryptedOtp,
  };

  @override
  List<Object?> get props => [
    contactId,
    encryptedOtp,
  ];
}