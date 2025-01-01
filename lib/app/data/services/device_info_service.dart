import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:spark_trackify/app/features/home_screen/models/device_info_model.dart';

class DeviceInfoService {
  static final DeviceInfoService _instance = DeviceInfoService._();

  DeviceInfoService._();

  static DeviceInfoService get instance => _instance;

  Future<DeviceInfoModel?> getDeviceInfo() async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    DeviceInfoModel? deviceInfoModel;
    String id = await FlutterUdid.udid;
    if (Platform.isAndroid) {
      return deviceInfoModel = _readAndroidBuildData(await deviceInfoPlugin.androidInfo, id);
    } else if (Platform.isIOS) {
      return deviceInfoModel = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo, id);
    }
    return deviceInfoModel;
  }

  DeviceInfoModel _readAndroidBuildData(AndroidDeviceInfo build, String deviceId) {
    log({
      'version.release': build.version.release,
      'id': deviceId,
      'manufacturer': build.manufacturer,
      'model': build.model,
    }.toString());
    return DeviceInfoModel(
        deviceId: deviceId, deviceName: build.model, modelName: build.manufacturer, os: "Android", version: build.version.release);
  }

  DeviceInfoModel _readIosDeviceInfo(IosDeviceInfo data, String deviceId) {
    log({
      'name': data.name,
      'systemName': data.systemName,
      'systemVersion': data.systemVersion,
      'model': data.model,
      'modelName': data.modelName,
      'id': deviceId,
    }.toString());

    return DeviceInfoModel(
        deviceId: deviceId, deviceName: data.name, modelName: data.modelName, os: "Ios", version: data.systemVersion);
  }
}
