import 'package:flutter/material.dart';
import 'package:spark_trackify/Utilities/Constants.dart';
import 'package:spark_trackify/Utilities/Routes.dart';
import 'package:spark_trackify/Utilities/ThemeColors.dart';


class DeviceListingScreen extends StatelessWidget {

  DeviceListingScreen({super.key});

  final deviceData = [AppImages.iPhone11 , AppImages.iPad10 , AppImages.iPad3];
  final deviceName = ["iphone 11" , "ipad 10thGen" , "ipad 3rdGen"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: List.generate(deviceData.length, (index) {
                  return GestureDetector(
                      onTap: (){
                         Navigator.pushNamed(context, RouteName.assignDetailScreen);
                      },
                      child: SingleDeviceTemplate(imageName: deviceData[index],deviceName: deviceName[index],)
                  );
                },
                ),
              ),
            )
          )
      ),
    );
  }
}


class SingleDeviceTemplate extends StatelessWidget {

  final String imageName;
  final String deviceName;

  const SingleDeviceTemplate({
    super.key,
    required this.imageName,
    required this.deviceName
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: AppColors.lightBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(imageName,fit: BoxFit.fitHeight,height: 70, width: 70,),

          const SizedBox(width: 10,),

          Text(deviceName,
            style: appTextStyle(textColor: AppColors.darkColor , fontSize: 18 , style: FontStyle.semibold),
          ),

          const Expanded(child: SizedBox()),
        ],
      ),

    );
  }
}
