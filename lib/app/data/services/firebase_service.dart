import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';

class FirebaseService {
  static final FirebaseService _instance = FirebaseService._();

  FirebaseService._();

  static FirebaseService get instance => _instance;

  Future<Stream<DatabaseEvent>> getStreamDeviceList() async {
    // List<DeviceDataModel> deviceList = [];
    // try {
    return FirebaseDatabase.instance.ref().child("deviceData").onValue;
    // final event = await FirebaseDatabase.instance.ref().child("deviceData").get();
    // } catch (e) {
    //   log("Error fetching deviceData: ${e.toString()}");
    // }
    // return deviceList;
  }

  Future<String> getToken() async {
    String token = "";
    try {
      final event = await FirebaseDatabase.instance.ref().child("token").get();
      if (event.value != null) {
        token = event.value as String;
      }
    } catch (e) {
      log("Error fetching Token: ${e.toString()}");
    }
    return token;
  }

  Future<void> addDeviceInfo(Map<String, dynamic> deviceInfo) async {
    try {
      await FirebaseDatabase.instance.ref().child("deviceData").child(deviceInfo["id"]).set(deviceInfo);
    } catch (e) {
      log("log: ${e.toString()}");
    }
  }

  Future<void> updateDeviceInfo(Map<String, dynamic> deviceInfo) async {
    try {
      await FirebaseDatabase.instance.ref().child("deviceData").child(deviceInfo["id"]).update(deviceInfo);
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
