import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:spark_trackify/app/features/home_screen/models/device_info_model.dart';

class DeviceInfoService {
  static final DeviceInfoService _instance = DeviceInfoService._();

  DeviceInfoService._();

  static DeviceInfoService get instance => _instance;

  Future<DeviceInfoModel?> getDeviceInfo() async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    DeviceInfoModel? deviceInfoModel;
    if (Platform.isAndroid) {
      return deviceInfoModel = _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
    } else if (Platform.isIOS) {
      return deviceInfoModel = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
    }

    return deviceInfoModel;
  }

  DeviceInfoModel _readAndroidBuildData(AndroidDeviceInfo build) {
    return DeviceInfoModel(
        deviceId: build.id.replaceAll(".", ""),
        deviceName: build.model,
        modelName: build.manufacturer,
        os: "Android",
        version: build.version.release);
  }

  DeviceInfoModel _readIosDeviceInfo(IosDeviceInfo data) {
    log({
      'name': data.name,
      'systemName': data.systemName,
      'systemVersion': data.systemVersion,
      'model': data.model,
      'modelName': data.modelName,
      'localizedModel': data.localizedModel,
      'identifierForVendor': data.identifierForVendor,
      'isPhysicalDevice': data.isPhysicalDevice,
      'isiOSAppOnMac': data.isiOSAppOnMac,
      'utsname.sysname:': data.utsname.sysname,
      'utsname.nodename:': data.utsname.nodename,
      'utsname.release:': data.utsname.release,
      'utsname.version:': data.utsname.version,
      'utsname.machine:': data.utsname.machine,
    }.toString());

    return DeviceInfoModel(
        deviceId: data.identifierForVendor ?? "",
        deviceName: data.name,
        modelName: data.modelName,
        os: "Ios",
        version: data.systemVersion);
  }
}
