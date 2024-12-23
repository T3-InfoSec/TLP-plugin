import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:tlp_client/src/model/messagetype.dart';
import 'package:tlp_client/src/service/response_message_handlers/compaint_handler.dart';
import 'package:tlp_client/src/service/response_message_handlers/tlp_handler.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../utils/encryption.dart';

class WebSocketClient {
  final String clientId;
  final WebSocketChannel _channel;
  final Encryption _encryption;

  WebSocketClient(String url, this.clientId)
      : _channel = WebSocketChannel.connect(Uri.parse('$url/$clientId')),
        _encryption = Encryption();

  void sendMessage(String message) {
    final encryptedMessage = _encryption.encryptMessage(message);
    _channel.sink.add(encryptedMessage);
  }

  void listen(void Function(String message) onMessage) {
    _channel.stream.listen((responseMessage) {
      try {
        final decryptedMessage = _encryption.decryptMessage(responseMessage);
        final type = jsonDecode(decryptedMessage)['type'];
        final data = jsonDecode(decryptedMessage)['data'];

        final messageType = getMessageType(type);
        switch (messageType) {
          case MessageType.pong:
            onMessage("PONG from Server √");
            break;
          case MessageType.tlpResponse:
            handlerTlpResponse(data);
            break;
          case MessageType.complaint:
            handlerComplaintResponse(data);

            break;
          default:
            // Handle unknown message type
            break;
        }
        if (kDebugMode) {
          print('Received message: $decryptedMessage');
        }
      } catch (e) {
        if (kDebugMode) {
          print('Error decrypting message: $e');
        }
      }
    });
  }

  void sendPing() {
    sendMessage(jsonEncode({'type': 'ping', 'data': '{}'}));
  }

  Future<void> close() async {
    await _channel.sink.close();
  }
}
