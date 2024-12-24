import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';

import '../../features/home_screen/models/deviceDataModel.dart';

class FirebaseService {
  static final FirebaseService _instance = FirebaseService._();

  FirebaseService._();

  static FirebaseService get instance => _instance;

  Future<List<DeviceDataModel>> getDeviceList() async {
    List<DeviceDataModel> deviceList = [];
    try {
      final event = await FirebaseDatabase.instance.ref().child("deviceData").get();
      final deviceDataMap = event.value as Map<dynamic, dynamic>?;
      if (deviceDataMap != null) {
        deviceDataMap.forEach((key, value) {
          deviceList.add(DeviceDataModel.fromMap(key, value));
        });
      } else {
        log("No data found under 'deviceData'.");
      }
    } catch (e) {
      log("Error fetching deviceData: ${e.toString()}");
    }
    return deviceList;
  }

  Future<void> addDeviceInfo(Map<String, dynamic> deviceInfo) async {
    try {
      await FirebaseDatabase.instance.ref().child("deviceData").child(deviceInfo["id"]).set(deviceInfo);
    } catch (e) {
      log("log: ${e.toString()}");
    }
  }

  Future<bool> isDeviceRegisterInDatabase(String deviceId) async {
    final data = await FirebaseDatabase.instance.ref().child("deviceData").child(deviceId).once();
    log("log: ${data.snapshot.value}");
    return data.snapshot.value != null;
  }
}
