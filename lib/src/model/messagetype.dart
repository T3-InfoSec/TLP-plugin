enum MessageType {
  ping,
  pong,
  tlp,
  tlpResponse,
  complaint,
  complaintResponse,
  exit,
  exitResponse,
  unknown,
}

MessageType getMessageType(String? type) {
  switch (type) {
    case 'ping':
      return MessageType.ping;
    case 'pong':
      return MessageType.pong;
    case 'tlp':
      return MessageType.tlp;
    case 'tlpResponse':
      return MessageType.tlpResponse;
    case 'complaint':
      return MessageType.complaint;
    case 'complaintResponse':
      return MessageType.complaintResponse;
    case 'exit':
      return MessageType.exit;
    case 'exitResponse':
      return MessageType.exitResponse;
    default:
      return MessageType.unknown;
  }
}
