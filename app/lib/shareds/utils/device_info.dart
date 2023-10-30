import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';

class DeviceInfo {
  String deviceName;
  String brand;
  String model;
  String operatingSystem;
  String osVersion;

  DeviceInfo({
    required this.deviceName,
    required this.brand,
    required this.model,
    required this.operatingSystem,
    required this.osVersion,
  });

  static Future<DeviceInfo?> getInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    try {
      if (defaultTargetPlatform == TargetPlatform.android) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        return DeviceInfo(
          deviceName: androidInfo.device,
          brand: androidInfo.brand,
          model: androidInfo.model,
          operatingSystem: 'Android OS',
          osVersion: androidInfo.version.release,
        );
      } else if (defaultTargetPlatform == TargetPlatform.iOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        return DeviceInfo(
          deviceName: iosInfo.utsname.machine,
          brand: iosInfo.model,
          model: iosInfo.name,
          operatingSystem: 'iOS',
          osVersion: iosInfo.systemVersion,
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error retrieving device information: $e');
      }
    }
    return null;
  }
}
