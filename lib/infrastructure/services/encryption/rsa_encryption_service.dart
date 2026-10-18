import 'package:encrypt/encrypt.dart';
import 'package:mustore/core/services/encryption/encryption_service.dart';
import 'package:pointycastle/asymmetric/api.dart';

final class RsaEncryptionService implements EncryptionService {
  @override
  String encrypt(String plainText, String publicKey) {
    final pem = _toPem(publicKey);
    final parsedKey = RSAKeyParser().parse(pem) as RSAPublicKey;

    final encrypter = Encrypter(
      RSA(
        publicKey: parsedKey,
        encoding: RSAEncoding.OAEP,
        digest: RSADigest.SHA256,
      ),
    );

    return encrypter.encrypt(plainText).base64;
  }

  String _toPem(String base64Key) {
    final cleaned = base64Key.replaceAll(RegExp(r'\s'), '');
    final lines = RegExp('.{1,64}')
        .allMatches(cleaned)
        .map((m) => m.group(0)!)
        .join('\n');
    return '-----BEGIN RSA PUBLIC KEY-----\n$lines\n-----END RSA PUBLIC KEY-----';
  }
}