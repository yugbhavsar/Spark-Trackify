import 'package:flutter/material.dart';
import 'package:spark_trackify/app/features/device_details_screen/device_details_screen.dart';

import '../features/home_screen/view/device_assign_screen.dart';
import '../features/home_screen/view/device_listing_screen.dart';
import '../features/home_screen/view/home_screen.dart';
import '../features/search_employee_screen/search_employee_screen.dart';
import '../features/splash_screen/splash_screen.dart';

class AppRoutes {
  static const String splashScreen = "SplashScreen";
  static const String homeScreen = "HomeScreen";
  static const String deviceListingScreen = "DeviceListingScreen";
  static const String deviceAssignScreen = "DeviceAssignScreen";
  static const String deviceDetailsScreen = "DeviceDetailScreen";
  static const String searchEmployeeScreen = "SearchEmployeeScreen";

  static Map<String, Widget Function(BuildContext)> appRoutes = {
    splashScreen: (context) => SplashScreen(),
    deviceListingScreen: (context) => DeviceListingScreen(),
    homeScreen: (context) => HomeScreen(),
    deviceAssignScreen: (context) => DeviceAssignScreen(),
    deviceDetailsScreen: (context) => DeviceDetailsScreen(),
    searchEmployeeScreen: (context) => SearchEmployeeScreen()
  };
}
