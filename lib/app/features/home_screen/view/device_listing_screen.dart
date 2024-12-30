import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spark_trackify/app/core/common/ThemeColors.dart';
import 'package:spark_trackify/app/features/home_screen/models/deviceDataModel.dart';
import 'package:spark_trackify/app/routes/app_routes.dart';

import '../../../data/utils/app_utils.dart';
import '../cubit/home_cubit.dart';

class DeviceListingScreen extends StatelessWidget {
  DeviceListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state.isLoading) {
            return Center(
                child: CircularProgressIndicator(
              color: AppColors.primaryGreen,
            ));
          }
          return ListView.builder(
            itemCount: state.deviceDataList.length,
            itemBuilder: (context, index) {
              DeviceDataModel deviceDataModel = state.deviceDataList[index];
              return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.deviceDetailsScreen, arguments: {"deviceData": deviceDataModel});
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
                ? Image.asset(
                    AppUtils.getDeviceImage(modelName: deviceDataModel.deviceImage ?? ""),
                    width: 70,
                    height: 70,
                  )
                : Image.asset(
                    AppUtils.getDeviceImage(modelName: deviceDataModel.modelName ?? ""),
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
            ))
          ],
        ),
      ),
    );
  }
}
