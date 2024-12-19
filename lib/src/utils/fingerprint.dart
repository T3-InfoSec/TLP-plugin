import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';

class SystemFingerprint {
  /// Retrieve stable system information for fingerprint generation.
  static Future<Map<String, String>> getStableSystemInfo() async {
    final deviceInfo = DeviceInfoPlugin();
    Map<String, String> systemInfo = {};

    try {
      if (Platform.isAndroid) {
        final androidInfo = await deviceInfo.androidInfo;
        systemInfo = {
          'system': 'Android',
          'device': androidInfo.device,
          'model': androidInfo.model,
          'androidVersion': androidInfo.version.release,
          'board': androidInfo.board,
          'manufacturer': androidInfo.manufacturer,
        };
      } else if (Platform.isIOS) {
        final iosInfo = await deviceInfo.iosInfo;
        systemInfo = {
          'system': 'iOS',
          'model': iosInfo.model,
          'name': iosInfo.name,
          'systemVersion': iosInfo.systemVersion,
          'identifierForVendor': iosInfo.identifierForVendor ?? 'unknown',
        };
      } else if (Platform.isMacOS) {
        final macInfo = await deviceInfo.macOsInfo;
        systemInfo = {
          'system': 'macOS',
          'model': macInfo.model,
          'osRelease': macInfo.osRelease,
          'arch': macInfo.arch,
        };
      } else if (Platform.isWindows) {
        final windowsInfo = await deviceInfo.windowsInfo;
        systemInfo = {
          'system': 'Windows',
          'computerName': windowsInfo.computerName,
          'osVersion': windowsInfo.displayVersion,
          'arch': windowsInfo.productId,
        };
      } else if (Platform.isLinux) {
        final linuxInfo = await deviceInfo.linuxInfo;
        systemInfo = {
          'system': 'Linux',
          'name': linuxInfo.name,
          'version': linuxInfo.version ?? 'unknown',
          'id': linuxInfo.id,
        };
      } else {
        systemInfo = {'system': 'Unknown', 'info': 'Unsupported platform'};
      }
    } catch (e) {
      systemInfo = {'error': 'Failed to retrieve system information'};
    }

    return systemInfo;
  }

  /// Generate a unique and consistent fingerprint for the system.
  static Future<String> generateFingerprint() async {
    final systemInfo = await getStableSystemInfo();

    // Convert system info to a stable string representation
    final infoStr = jsonEncode(systemInfo);

    // Generate SHA-256 hash of the system information
    final bytes = utf8.encode(infoStr);
    final fingerprint = sha256.convert(bytes).toString();

    // Use the first 12 characters for a shorter identifier
    final shortFingerprint = fingerprint.substring(0, 12);

    print('Generated system fingerprint: $shortFingerprint');
    print('System info: ${jsonEncode(systemInfo)}');

    return shortFingerprint;
  }
}
