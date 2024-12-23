import 'dart:convert';
import 'dart:typed_data';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:crypto/crypto.dart';

class Encryption {
  late final Uint8List key;

  Encryption() {
    // Generate the key from the password
    const String placeholderEncKeyPassword = String.fromEnvironment('PLACEHOLDER_ENCRYPTION_KEY_PASSWORD');
    final passwordBytes = utf8.encode(placeholderEncKeyPassword);
    key = sha256.convert(passwordBytes).bytes as Uint8List;
  }

  String encryptMessage(String plaintext) {
    final iv = encrypt.IV.fromSecureRandom(16); // Generate a random IV
    final encrypter = encrypt.Encrypter(encrypt.AES(encrypt.Key(key), mode: encrypt.AESMode.cbc));

    // Encrypt the plaintext
    final encrypted = encrypter.encrypt(plaintext, iv: iv);

    // Combine IV and ciphertext and encode in base64
    final combined = iv.bytes + encrypted.bytes;
    return base64.encode(combined);
  }

  String decryptMessage(String encryptedText) {
    // Decode the base64-encoded text
    final raw = base64.decode(encryptedText);

    // Extract IV and ciphertext
    final ivBytes = raw.sublist(0, 16);
    final ciphertextBytes = raw.sublist(16);
    final iv = encrypt.IV(ivBytes);
    final encrypter = encrypt.Encrypter(encrypt.AES(encrypt.Key(key), mode: encrypt.AESMode.cbc));

    // Decrypt the ciphertext

    final decrypted = encrypter.decryptBytes(
      encrypt.Encrypted(ciphertextBytes),
      iv: iv,
    );

    return utf8.decode(decrypted);
  }
}
