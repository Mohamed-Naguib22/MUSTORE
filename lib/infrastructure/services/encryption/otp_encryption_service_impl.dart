import 'package:mustore/core/config/otp_encryption_config.dart';
import 'package:mustore/core/services/encryption/encryption_service.dart';
import 'package:mustore/core/services/encryption/otp_encryption_service.dart';

final class OtpEncryptionServiceImpl implements OtpEncryptionService {
  OtpEncryptionServiceImpl({
    required EncryptionService rsaEncryptionService,
  })  : _rsa = rsaEncryptionService;

  final EncryptionService _rsa;

  @override
  String encrypt(String plainText) =>
      _rsa.encrypt(plainText, OtpEncryptionConfig.publicKey);
}