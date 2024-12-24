import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spark_trackify/app/data/services/device_info_service.dart';
import 'package:spark_trackify/app/data/services/firebase_service.dart';
import 'package:spark_trackify/app/routes/app_routes.dart';

import '../../../gen/assets.gen.dart';
import '../../data/utils/app_preference.dart';
import '../home_screen/models/deviceDataModel.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.homeScreen, (route) => false);
    });

    syncDeviceWithDatabase();
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((timeStamp) async {
      await AppPreference.instance.init();
    });
  }

  void syncDeviceWithDatabase() async {
    Map<String, dynamic> deviceInfo = await DeviceInfoService.instance.getDeviceInfo();
    bool isRegistered = await FirebaseService.instance.isDeviceRegisterInDatabase(deviceInfo["id"]);
    log("log: isRegister $isRegistered");
    if (!isRegistered) {
      DeviceDataModel deviceDataModel = DeviceDataModel()
        ..deviceName = deviceInfo["deviceName"]
        ..deviceId = deviceInfo["id"]
        ..modelName = deviceInfo["modelName"]
        ..version = deviceInfo["version"]
        ..os = deviceInfo["os"];

      await FirebaseService.instance.addDeviceInfo(deviceDataModel.toMap());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Hero(
            tag: "eSparkLogo",
            child: SvgPicture.asset(
              Assets.images.eSparkLogo.path,
              fit: BoxFit.fill,
              height: 55,
            )),
      ),
    );
  }
}
