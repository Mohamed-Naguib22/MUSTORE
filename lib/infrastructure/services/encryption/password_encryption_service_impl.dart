import 'package:mustore/core/config/password_encryption_config.dart';
import 'package:mustore/core/services/encryption/encryption_service.dart';
import 'package:mustore/core/services/encryption/password_encryption_service.dart';

final class PasswordEncryptionServiceImpl implements PasswordEncryptionService {
  PasswordEncryptionServiceImpl({
    required EncryptionService rsaEncryptionService,
  })  : _rsa = rsaEncryptionService;

  final EncryptionService _rsa;

  @override
  String encrypt(String plainText) =>
      _rsa.encrypt(plainText, PasswordEncryptionConfig.publicKey);
}