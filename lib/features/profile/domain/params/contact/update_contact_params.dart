import 'package:equatable/equatable.dart';

class UpdateContactParams extends Equatable {
  const UpdateContactParams({
    required this.contactId,
    required this.phoneNumber,
  });

  final String contactId;
  final String phoneNumber;

  Map<String, dynamic> toJson() => {
    'phoneNumber': phoneNumber,
  };

  @override
  List<Object?> get props => [
    contactId,
    phoneNumber,
  ];
}