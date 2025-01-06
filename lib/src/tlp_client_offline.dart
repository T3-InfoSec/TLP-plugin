import 'dart:convert';

import 'package:t3_crypto_objects/crypto_objects.dart';

class TlpClientOffline {
  final _tlp = Tlp();

  Future<List<int>> encrypt(String data) async {
    try {
      final Plaintext plaintext = Plaintext(utf8.encode(data));
      final encrytedData = await _tlp.encrypt(plaintext);
      return encrytedData.concatenation();
    } catch (e) {
      rethrow;
    }
  }

  Future<String> decrypt(List<int> data) async {
    try {
      if (data.isEmpty) {
        throw Exception('Empty data');
      }
      final decryptedData = await _tlp.decrypt(data);
      return utf8.decode(decryptedData.value);
    } catch (e) {
      rethrow;
    }
  }
}
