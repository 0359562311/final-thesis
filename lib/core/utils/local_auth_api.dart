import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuthAPI {
  static final _auth = LocalAuthentication();

  static Future<bool> hasFingerprint() async {
    try {
      final canCheck = await _auth.canCheckBiometrics;
      if (canCheck) {
        return (await _auth.getAvailableBiometrics())
            .contains(BiometricType.fingerprint);
      }
      return canCheck;
    } on PlatformException {
      return false;
    }
  }

  static Future<bool> authenticate() async {
    try {
      return await _auth.authenticate(
          localizedReason: "Quét vân tay để kiểm tra đăng nhập",
          useErrorDialogs: true,
          stickyAuth: true,
          biometricOnly: true);
    } on PlatformException {
      return false;
    }
  }
}
