import 'package:equatable/equatable.dart';

class RevokeSessionParams extends Equatable {
  final String refreshToken;

  const RevokeSessionParams({required this.refreshToken});

  Map<String, dynamic> toJson() => {'refreshToken': refreshToken};

  @override
  List<Object?> get props => [refreshToken];
}