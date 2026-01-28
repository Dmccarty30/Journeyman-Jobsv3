import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_auth/local_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'biometric_service.g.dart';

@Riverpod(keepAlive: true)
BiometricService biometricService(Ref ref) {
  return BiometricService();
}

class BiometricService {
  final LocalAuthentication _auth = LocalAuthentication();

  Future<bool> get isBiometricAvailable async {
    try {
      final bool canAuthenticateWithBiometrics = await _auth.canCheckBiometrics;
      final bool canAuthenticate =
          canAuthenticateWithBiometrics || await _auth.isDeviceSupported();
      return canAuthenticate;
    } on PlatformException catch (e) {
      debugPrint('Error checking biometrics: $e');
      return false;
    }
  }

  Future<List<BiometricType>> getAvailableBiometrics() async {
    try {
      return await _auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      debugPrint('Error getting biometrics: $e');
      return [];
    }
  }

  Future<bool> authenticate({
    String localizedReason = 'Please authenticate to access the app',
  }) async {
    try {
      return await _auth.authenticate(
        localizedReason: localizedReason,
      );
    } on PlatformException catch (e) {
      debugPrint('Error authenticating: $e');
      return false;
    }
  }
}
