import 'package:device_info_plus/device_info_plus.dart';

class DeviceInfo {
  String? deviceId;
  String? deviceName;

  Future init() async {
    try {
      final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceId = androidInfo.androidId;
      deviceName = androidInfo.device;
    } on Exception {}
  }
}
