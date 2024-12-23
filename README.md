# TLP-plugin
Plugin for implementing instantiation and solution of time-lock puzzles

# Detailed Documentation for `TLP` and `TlpClient` Classes

This documentation provides an in-depth explanation of the `TLP` and `TlpClient` classes and their functionalities.

---

## `TLP` Class

The `TLP` class is responsible for handling cryptographic operations involving prime numbers, modular arithmetic, and other mathematical computations.

### Constructor

```dart
TLP({required int bits})
```

- **Parameters**:
  - `bits`: The bit length for generating primes and base numbers.

- **Description**: Initializes the `TLP` class with a `PrimeGenerator` instance for generating cryptographic primes and performing mathematical computations.

---

### Methods

#### `BigInt get generatedBase`
- **Description**: Returns a randomly generated base using the `_generateBase` method.

#### `_generateBase()`
- **Description**: Generates a random base value using the `PrimeGenerator`.

#### `BigInt get generatedPrime`
- **Description**: Returns a generated prime number using the `_generatePrime` method.

#### `_generatePrime()`
- **Description**: Generates a prime number using the `PrimeGenerator`.

#### `comupteProductOfPrime(BigInt prime1, BigInt prime2)`
- **Parameters**:
  - `prime1`: First prime number.
  - `prime2`: Second prime number.
- **Returns**: The product of the two prime numbers.

#### `BigInt calculateCarmichael(BigInt prime1, BigInt prime2)`
- **Description**: Calculates the Carmichael function for the product of two primes.
- **Parameters**:
  - `prime1`: First prime number.
  - `prime2`: Second prime number.
- **Returns**: The Carmichael value.

#### `BigInt calculateTotient(BigInt prime1, BigInt prime2)`
- **Description**: Calculates the totient for two prime numbers.
- **Parameters**:
  - `prime1`: First prime number.
  - `prime2`: Second prime number.
- **Returns**: The totient value.

#### `BigInt modExp(BigInt base, BigInt exp, BigInt mod)`
- **Description**: Performs modular exponentiation.
- **Parameters**:
  - `base`: The base number.
  - `exp`: The exponent.
  - `mod`: The modulus.
- **Returns**: Result of \( \text{base}^{\text{exp}} \mod \text{mod} \).

#### `BigInt extendedGCD(BigInt a, BigInt b)`
- **Description**: Finds the greatest common divisor using the extended Euclidean algorithm.
- **Parameters**:
  - `a`, `b`: The numbers.
- **Returns**: The greatest common divisor.

#### `BigInt modInverse(BigInt a, BigInt m)`
- **Description**: Calculates the modular inverse of `a` modulo `m`.
- **Parameters**:
  - `a`: The number.
  - `m`: The modulus.
- **Returns**: The modular inverse.

---

## `TlpClient` Class

The `TlpClient` class acts as a client that interacts with a WebSocket server, performs cryptographic operations using the `TLP` class, and handles sending and receiving messages.

### Constructor

```dart
TlpClient()
```

- **Description**: Initializes the client, generates cryptographic values, and prepares the WebSocket connection.

---

### Fields

#### `_websocketUrl`
- **Description**: URL of the WebSocket server.

#### `_clientId`
- **Description**: Unique client ID, generated using the `SystemFingerprint` utility.

#### `_client`
- **Description**: Instance of `WebSocketClient` for handling WebSocket communication.

#### `_pingTimer`
- **Description**: Timer for sending periodic pings to the server.

#### `_tlpInstance`
- **Description**: Instance of the `TLP` class for cryptographic operations.

#### `prime1`, `prime2`, `product`, `baseG`, `base2`, `t`, `fastPower`
- **Description**: Cryptographic values used for operations like prime generation, modular exponentiation, and message encryption.

---

### Methods

#### `Future<void> initialize()`
- **Description**: Initializes the client by generating a unique client ID and setting up the WebSocket connection.

#### `void start({required void Function(String message) onMessage})`
- **Parameters**:
  - `onMessage`: A callback function that processes incoming messages.
- **Description**: Starts the client, listens for incoming messages, and sends periodic pings.

#### `void sendTlpMessage(BigInt t)`
- **Parameters**:
  - `t`: A BigInt value used for cryptographic computation.
- **Description**:
  - Calculates the Carmichael function, fast exponentiation, and the final `fastPower`.
  - Encrypts and stores the `fastPower` in local storage.
  - Sends a TLP message to the server.

#### `void sendComplaint(dynamic complaintData)`
- **Parameters**:
  - `complaintData`: Data related to a complaint.
- **Description**: Sends a complaint message to the server.

#### `Future<void> stop()`
- **Description**: Stops the client by canceling the ping timer and closing the WebSocket connection.

---

### Example Usage

```dart
void main() async {
  final client = TlpClient();
  await client.initialize();

  client.start(onMessage: (message) {
    print("Received: $message");
  });

  final t = BigInt.parse("123456789");
  client.sendTlpMessage(t);

  // Stop the client after some time
  await Future.delayed(Duration(seconds: 10));
  await client.stop();
}
```

This code demonstrates how to initialize the `TlpClient`, start listening for messages, send a TLP message, and stop the client after a delay.

---

### Summary

The `TLP` and `TlpClient` classes provide a robust framework for cryptographic operations and WebSocket communication. These classes are designed to handle modular arithmetic, secure message transmission, and interaction with a WebSocket server, making them suitable for secure, real-time applications.