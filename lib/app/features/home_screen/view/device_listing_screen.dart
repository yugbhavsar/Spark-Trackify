import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:spark_trackify/app/core/common/ThemeColors.dart';
import 'package:spark_trackify/app/features/home_screen/models/deviceDataModel.dart';
import 'package:spark_trackify/app/routes/app_routes.dart';
import 'package:spark_trackify/gen/assets.gen.dart';

class DeviceListingScreen extends StatelessWidget {
  DeviceListingScreen({super.key, required this.deviceDataList, this.isDeviceRegistered = false});

  final List<DeviceDataModel> deviceDataList;
  final bool isDeviceRegistered;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: (deviceDataList.isEmpty)
          ? Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Assets.svgs.emptyData.svg(fit: BoxFit.fitWidth, width: 300, height: 300),
                      Text("No any Devices Found",
                          style: appTextStyle(textColor: AppColors.darkColor, fontSize: 26, style: FontStyle.medium)),
                    ],
                  ),
                  // SizedBox(height: 32),
                  if (isDeviceRegistered) ...[
                    Column(
                      children: [
                        Text("Swipe right and Assign your device",
                            style: appTextStyle(textColor: AppColors.primaryGreen, fontSize: 14, style: FontStyle.medium)),
                        SizedBox(height: 32),
                        Assets.images.rotate.image(width: 80, height: 80, color: AppColors.primaryGreen),
                      ],
                    )
                  ]
                ],
              ),
            )
          : ListView.builder(
              itemCount: deviceDataList.length,
              itemBuilder: (context, index) {
                DeviceDataModel deviceDataModel = deviceDataList[index];
                return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.deviceDetailsScreen, arguments: {"deviceData": deviceDataModel});
                    },
                    child: SingleDeviceTemplate(
                      deviceDataModel: deviceDataModel,
                    ));
              },
            ),
    ));
  }
}

class SingleDeviceTemplate extends StatelessWidget {
  final DeviceDataModel deviceDataModel;

  const SingleDeviceTemplate({
    super.key,
    required this.deviceDataModel,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.lightBackground,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (deviceDataModel.deviceImage?.isNotEmpty ?? false) ...[
              CachedNetworkImage(
                imageUrl: deviceDataModel.deviceImage ?? "",
                width: 70,
                height: 70,
                fit: BoxFit.fitHeight,
                errorWidget: (context, url, error) => Assets.phones.phone.image(),
              )
            ],
            SizedBox(width: 8),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  deviceDataModel.deviceName ?? "",
                  style: appTextStyle(textColor: AppColors.darkColor, fontSize: 20, style: FontStyle.semibold),
                ),
                SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Assign For",
                            style: appTextStyle(textColor: Colors.grey.withOpacity(.8), fontSize: 14, style: FontStyle.medium),
                          ),
                          Text(
                            deviceDataModel.currentActiveUser?.assignFor?.name ?? "-",
                            style: appTextStyle(textColor: AppColors.darkColor, fontSize: 14, style: FontStyle.medium),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Assign To",
                            style: appTextStyle(textColor: Colors.grey.withOpacity(.8), fontSize: 14, style: FontStyle.medium),
                          ),
                          Text(
                            "${deviceDataModel.currentActiveUser?.firstName ?? ""} ${deviceDataModel.currentActiveUser?.lastName ?? "-"}",
                            style: appTextStyle(textColor: AppColors.darkColor, fontSize: 14, style: FontStyle.medium),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            )),
            if (deviceDataModel.currentActiveUser == null) ...[Assets.images.unassign.image(width: 50, height: 50)]
          ],
        ),
      ),
    );
  }
}
