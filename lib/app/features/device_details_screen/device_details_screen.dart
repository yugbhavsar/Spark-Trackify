import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:spark_trackify/app/features/home_screen/models/deviceDataModel.dart';
import 'package:spark_trackify/app/features/search_employee_screen/search_employee_screen.dart';
import 'package:spark_trackify/app/routes/app_routes.dart';

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
          .firstWhereOrNull((element) =>
              element.path.contains(deviceDataModel?.currentActiveUser?.assignFor?.name.toLowerCase() ?? Assets.images.unassign.path))
          ?.path;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Assets.images.backArrow.image(width: 32, height: 32),
            )),
        actions: [
          GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.historyScreen, arguments: {"historyData": deviceDataModel?.history});
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child:
                    Text("History", style: appTextStyle(textColor: AppColors.primaryGreen, fontSize: 20, style: FontStyle.semibold)),
              ))
        ],
        backgroundColor: Colors.white,
        title: Text(deviceDataModel?.deviceName ?? "",
            style: appTextStyle(textColor: AppColors.darkColor, fontSize: 18, style: FontStyle.semibold)),
      ),
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
              Center(
                child: (deviceDataModel?.deviceImage?.isNotEmpty ?? false)
                    ? CachedNetworkImage(
                        imageUrl: deviceDataModel?.deviceImage ?? "",
                        errorWidget: (context, url, error) => Assets.phones.phone.image(),
                        fit: BoxFit.fitHeight,
                        height: 250)
                    : Assets.phones.phone.image(),
              ),
              const SizedBox(
                height: 16,
              ),
              if (deviceDataModel?.currentActiveUser != null) ...[
                Text(
                  "Assign To : ",
                  style: appTextStyle(textColor: Colors.black, fontSize: 18, style: FontStyle.medium),
                ),
                SizedBox(height: 8),
                EmployeeCardView(
                    profileImage: deviceDataModel?.currentActiveUser?.empImage,
                    fullName: "${deviceDataModel?.currentActiveUser?.firstName} ${deviceDataModel?.currentActiveUser?.lastName}",
                    department: deviceDataModel?.currentActiveUser?.department)
              ],
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
                  Text(deviceDataModel?.currentActiveUser?.assignFor?.name ?? "Unassign",
                      style: appTextStyle(textColor: Colors.black, fontSize: 22, style: FontStyle.medium)),
                ],
              ),
              if (deviceDataModel?.currentActiveUser != null) ...[
                SizedBox(height: 16),
                Text(
                  "Note : ",
                  style: appTextStyle(textColor: Colors.black, fontSize: 18, style: FontStyle.medium),
                ),
                SizedBox(height: 8),
                Text(deviceDataModel?.currentActiveUser?.note ?? "",
                    style: appTextStyle(textColor: Colors.black, fontSize: 16, style: FontStyle.regular)),
              ],
              SizedBox(height: 20),
            ],
          ),
        ),
      )),
    );
  }
}
