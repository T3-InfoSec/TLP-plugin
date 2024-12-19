class TlpMessage {
  final BigInt t;
  final BigInt product;
  final BigInt baseg;
  const TlpMessage({
    required this.t,
    required this.product,
    required this.baseg,
  });

  factory TlpMessage.fromJson(Map<String, dynamic> json) {
    return TlpMessage(
      t: BigInt.parse(json['t']),
      product: BigInt.parse(json['product']),
      baseg: BigInt.parse(json['baseg']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      't': t.toString(),
      'product': product.toString(),
      'baseg': baseg.toString(),
    };
  }
}

class TlpResponse {
  final String answer;
  final String fingerprint;
  const TlpResponse({
    required this.answer,
    required this.fingerprint,
  });
  factory TlpResponse.fromJson(Map<String, dynamic> json) {
    return TlpResponse(
      answer: json['answer'],
      fingerprint: json['fingerprint'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'answer': answer.toString(),
      'fingerprint': fingerprint,
    };
  }
}
