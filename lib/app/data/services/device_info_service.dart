import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

class DeviceInfoService {
  static final DeviceInfoService _instance = DeviceInfoService._();

  DeviceInfoService._();

  static DeviceInfoService get instance => _instance;

  Future<Map<String, dynamic>> getDeviceInfo() async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    Map<String, dynamic> deviceInfo = {};
    if (Platform.isAndroid) {
      deviceInfo = _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
    } else if (Platform.isIOS) {
      deviceInfo = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
    }
    return deviceInfo;
  }

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'id': build.id.replaceAll(".", ""),
      'deviceName': build.model,
      'modelName': build.manufacturer,
      'version': build.version.release,
      "os": "Android"
    };
  }

  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
    return <String, dynamic>{
      'id': data.identifierForVendor,
      'deviceName': data.name,
      'modelName': data.model,
      'version': data.systemVersion,
      "os": "Ios"
    };
  }
}
