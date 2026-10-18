import 'package:equatable/equatable.dart';
import 'package:mustore/features/auth/domain/enums/login_provider.dart';

class ExternalLoginParams extends Equatable {
  final String idToken;
  final LoginProvider loginProvider;

  const ExternalLoginParams({
    required this.idToken,
    required this.loginProvider,
  });

  Map<String, dynamic> toJson() => {
    'idToken': idToken,
    'encryptedPassword': loginProvider.value,
  };

  @override
  List<Object?> get props => [idToken, loginProvider];
}