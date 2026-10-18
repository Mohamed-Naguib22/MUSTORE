import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mustore/core/error/failure.dart';
import 'package:mustore/core/services/auth/external_auth_service.dart';
import 'package:mustore/features/auth/domain/enums/login_provider.dart';

final class FirebaseExternalAuthServiceImpl implements ExternalAuthService {
  FirebaseExternalAuthServiceImpl({FirebaseAuth? auth})
      : _auth = auth ?? FirebaseAuth.instance;

  final FirebaseAuth _auth;

  static const _cancelCodes = {'canceled', 'web-context-canceled'};

  @override
  Future<Either<Failure, String?>> signIn(LoginProvider provider) async {
    final authProvider = switch (provider) {
      LoginProvider.google => GoogleAuthProvider(),
      _ => null,
    };

    if (authProvider == null) return const Left(UnknownFailure());

    try {
      final credential = await _auth.signInWithProvider(authProvider);
      return Right(await credential.user?.getIdToken());
    } on FirebaseAuthException catch (e) {
      if (_cancelCodes.contains(e.code)) return const Right(null);
      return const Left(UnknownFailure());
    } catch (_) {
      return const Left(UnknownFailure());
    }
  }
}