import 'package:flutter_test/flutter_test.dart';
import 'package:tlp_client/src/tlp_client_offline.dart';

void main() {
  group('TlpClientOffline', () {
    late TlpClientOffline client;

    setUp(() {
      client = TlpClientOffline();
    });

    group('encryption and decryption', () {
      test('successfully encrypts and decrypts simple string', () async {
        const testData = 'Hello, World!';
        final encrypted = await client.encrypt(testData);
        final decrypted = await client.decrypt(encrypted);

        expect(decrypted, equals(testData));
      });

      test('handles empty string', () async {
        const testData = '';
        final encrypted = await client.encrypt(testData);
        final decrypted = await client.decrypt(encrypted);

        expect(decrypted, equals(testData));
      });

      test('handles special characters', () async {
        const testData = '!@#\$%^&*()_+-=[]{}|;:,.<>?`~';
        final encrypted = await client.encrypt(testData);
        final decrypted = await client.decrypt(encrypted);

        expect(decrypted, equals(testData));
      });

      test('handles unicode characters', () async {
        const testData = '你好世界🌍';
        final encrypted = await client.encrypt(testData);
        final decrypted = await client.decrypt(encrypted);

        expect(decrypted, equals(testData));
      });

      test('handles multi-line text', () async {
        const testData = '''
First line
Second line
Third line with unicode 你好
''';
        final encrypted = await client.encrypt(testData);
        final decrypted = await client.decrypt(encrypted);

        expect(decrypted, equals(testData));
      });

      test('handles large text', () async {
        final testData = 'A' * 1000;
        final encrypted = await client.encrypt(testData);
        final decrypted = await client.decrypt(encrypted);

        expect(decrypted, equals(testData));
      });

      test('encrypted data is different for same input', () async {
        const testData = 'Hello, World!';
        final encrypted1 = await client.encrypt(testData);
        final encrypted2 = await client.encrypt(testData);

        expect(encrypted1, isNot(equals(encrypted2)));

        // But both should decrypt to the same value
        final decrypted1 = await client.decrypt(encrypted1);
        final decrypted2 = await client.decrypt(encrypted2);
        expect(decrypted1, equals(testData));
        expect(decrypted2, equals(testData));
      });
    });

    group('error handling', () {
      test('throws on empty decrypt data', () {
        expect(
          () => client.decrypt([]),
          throwsA(isA<Exception>()),
        );
      });

      test('throws on corrupted data', () async {
        const testData = 'Test message';
        final encrypted = await client.encrypt(testData);
        encrypted[0] = (encrypted[0] + 1) % 256; // Corrupt the first byte

        expect(
          () => client.decrypt(encrypted),
          throwsA(isA<Exception>()),
        );
      });
    });
  });
}
