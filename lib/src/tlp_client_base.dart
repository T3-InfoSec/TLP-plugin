// lib/tlp_client.dart

import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tlp_client/src/model/messagetype.dart';
import 'package:tlp_client/src/utils/encryption.dart';
import 'package:tlp_client/tlp_client.dart';

import 'service/websocket_client.dart';

class TlpClient {
  final String _websocketUrl = "ws://localhost:8000/ws/client";

  late final String _clientId;
  late final WebSocketClient _client;
  late final Timer _pingTimer;
  final _tlpInstance = TLP(bits: 256);
  late BigInt prime1, prime2, product, baseG, base2, t, fastPower = BigInt.zero;
  final Database db = Database();
  TlpClient() {
    prime1 = _tlpInstance.generatedPrime;
    prime2 = _tlpInstance.generatedPrime;
    baseG = _tlpInstance.generatedBase;
    base2 = BigInt.from(2);
    product = _tlpInstance.comupteProductOfPrime(prime1, prime2);
  }

  /// Initializes the client asynchronously.
  Future<void> initialize() async {
    //
    _clientId = '_temporal_client_id';
    _client = WebSocketClient(_websocketUrl, _clientId);
  }

  /// Starts the client and listens for incoming messages.
  void start({required void Function(String message) onMessage}) {
    _client.listen(onMessage);

    // Send periodic pings
    const pingInterval = Duration(minutes: 5);
    _pingTimer = Timer.periodic(pingInterval, (_) {
      _client.sendPing();
    });
  }

  /// Sends a custom message to the server.
  void sendTlpMessage(BigInt t) async {
    final carmichael = _tlpInstance.calculateCarmichael(prime1, prime2);
    final fastExponent = _tlpInstance.modExp(base2, t, carmichael);
    fastPower = _tlpInstance.modExp(baseG, fastExponent, product);

    Encryption encryption = Encryption();
    final encryptedFastPower = encryption.encryptMessage(fastPower.toString());
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('fast_power', encryptedFastPower);
    // now send tlp message
    final TlpMessage tlpMessage = TlpMessage(
      t: t,
      baseg: baseG,
      product: product,
    );

    final message = {"type": MessageType.tlp.name, "data": tlpMessage.toJson()};
    _client.sendMessage(json.encode(message));
  }

  void sendComplaint(dynamic complaintData) {
    _client.sendMessage(json.encode(complaintData));
  }

  /// Stops the client and closes the WebSocket connection.
  Future<void> stop() async {
    _pingTimer.cancel();
    await _client.close();
  }
}
