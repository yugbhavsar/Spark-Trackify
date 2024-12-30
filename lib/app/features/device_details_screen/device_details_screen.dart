import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:spark_trackify/app/data/utils/app_utils.dart';
import 'package:spark_trackify/app/features/home_screen/models/deviceDataModel.dart';
import 'package:spark_trackify/app/features/search_employee_screen/search_employee_screen.dart';

import '../../../gen/assets.gen.dart';
import '../../core/common/ThemeColors.dart';

class DeviceDetailsScreen extends StatefulWidget {
  const DeviceDetailsScreen({super.key});

  @override
  State<DeviceDetailsScreen> createState() => _DeviceDetailsScreenState();
}

class _DeviceDetailsScreenState extends State<DeviceDetailsScreen> {
  DeviceDataModel? deviceDataModel;
  String? assignForImagePath;

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((timeStamp) {
      Map? args = ModalRoute.settingsOf(context)?.arguments as Map?;
      deviceDataModel = args?["deviceData"];
      assignForImagePath = Assets.images.values
          .firstWhereOrNull(
              (element) => element.path.contains(deviceDataModel?.currentActiveUser?.assignFor?.name.toLowerCase() ?? "-1"))
          ?.path;
      log("log: assign for: ${assignForImagePath}");
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        physics: const ScrollPhysics(parent: BouncingScrollPhysics()),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Assets.images.backArrow.image(width: 32, height: 32)),
                  SizedBox(width: 16),
                  Text(
                    textAlign: TextAlign.center,
                    deviceDataModel?.deviceName ?? "",
                    style: appTextStyle(textColor: AppColors.darkColor, fontSize: 24, style: FontStyle.semibold),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Center(
                child: Image.asset(AppUtils.getDeviceImage(modelName: deviceDataModel?.modelName ?? ""),
                    fit: BoxFit.fitHeight, height: 300),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                "Assign To : ",
                style: appTextStyle(textColor: Colors.black, fontSize: 18, style: FontStyle.medium),
              ),
              SizedBox(height: 8),
              EmployeeCardView(
                  profileImage: deviceDataModel?.currentActiveUser?.empImage,
                  fullName: "${deviceDataModel?.currentActiveUser?.firstName} ${deviceDataModel?.currentActiveUser?.lastName}",
                  department: deviceDataModel?.currentActiveUser?.department),
              SizedBox(height: 20),
              Text(
                "Assign For : ",
                style: appTextStyle(textColor: Colors.black, fontSize: 18, style: FontStyle.medium),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  if (assignForImagePath != null && (assignForImagePath?.isNotEmpty ?? false)) ...[
                    Image.asset(assignForImagePath ?? "", width: 48, height: 48, fit: BoxFit.cover),
                    SizedBox(width: 16)
                  ],
                  Text(deviceDataModel?.currentActiveUser?.assignFor?.name ?? "",
                      style: appTextStyle(textColor: Colors.black, fontSize: 22, style: FontStyle.medium)),
                ],
              ),
              SizedBox(height: 16),
              Text(
                "Note : ",
                style: appTextStyle(textColor: Colors.black, fontSize: 18, style: FontStyle.medium),
              ),
              SizedBox(height: 8),
              Text(deviceDataModel?.currentActiveUser?.note ?? "",
                  style: appTextStyle(textColor: Colors.black, fontSize: 16, style: FontStyle.regular)),
              SizedBox(height: 20),
            ],
          ),
        ),
      )),
    );
  }
}
