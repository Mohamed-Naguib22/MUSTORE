import 'package:dartz/dartz.dart';
import 'package:mustore/core/error/failure.dart';
import 'package:mustore/features/auth/domain/enums/login_provider.dart';

abstract interface class ExternalAuthService {
  Future<Either<Failure, String?>> signIn(LoginProvider provider);
}