import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spark_trackify/app/core/common/ThemeColors.dart';
import 'package:spark_trackify/app/features/home_screen/models/deviceDataModel.dart';
import 'package:spark_trackify/app/routes/app_routes.dart';
import 'package:spark_trackify/gen/assets.gen.dart';

import 'cubit/home_cubit.dart';

class DeviceListingScreen extends StatelessWidget {
  DeviceListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return ListView.builder(
            itemCount: state.deviceDataList.length,
            itemBuilder: (context, index) {
              DeviceDataModel deviceDataModel = state.deviceDataList[index];
              return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.assignDetailScreen);
                  },
                  child: SingleDeviceTemplate(
                    deviceDataModel: deviceDataModel,
                  ));
            },
          );
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
            deviceDataModel.deviceImage != null && (deviceDataModel.deviceImage?.isNotEmpty ?? false)
                ? Image.network(
                    deviceDataModel.deviceImage ?? "",
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                  )
                : Assets.images.iphone11.image(
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                  ),
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
                            deviceDataModel.currentActiveUser?.assignFor ?? "-",
                            style: appTextStyle(textColor: AppColors.darkColor, fontSize: 15, style: FontStyle.medium),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
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
                            style: appTextStyle(textColor: AppColors.darkColor, fontSize: 15, style: FontStyle.medium),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
