import 'package:flutter/material.dart';

import '../features/device_assign_details_screen/device_assign_detail_screen.dart';
import '../features/home_screen/device_listing_screen.dart';
import '../features/home_screen/home_screen.dart';
import '../features/search_employee_screen/search_employee_screen.dart';
import '../features/splash_screen/splash_screen.dart';

class AppRoutes {
  static const String splashScreen = "SplashScreen";
  static const String homeScreen = "HomeScreen";
  static const String deviceListingScreen = "DeviceListingScreen";
  static const String assignDetailScreen = "AssignDetailScreen";
  static const String searchEmployeeScreen = "SearchEmployeeScreen";

  static Map<String, Widget Function(BuildContext)> appRoutes = {
    splashScreen: (context) => SplashScreen(),
    deviceListingScreen: (context) => DeviceListingScreen(),
    homeScreen: (context) => HomeScreen(),
    assignDetailScreen: (context) => DeviceAssignDetailScreen(),
    searchEmployeeScreen: (context) => SearchEmployeeScreen()
  };
}
