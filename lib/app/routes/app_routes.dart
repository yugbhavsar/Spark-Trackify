import 'package:flutter/material.dart';
import 'package:spark_trackify/app/features/device_details_screen/device_details_screen.dart';
import 'package:spark_trackify/app/features/history_screen/history_screen.dart';

import '../features/home_screen/view/home_screen.dart';
import '../features/search_employee_screen/search_employee_screen.dart';
import '../features/splash_screen/splash_screen.dart';

class AppRoutes {
  static const String splashScreen = "SplashScreen";
  static const String homeScreen = "HomeScreen";
  static const String deviceDetailsScreen = "DeviceDetailScreen";
  static const String searchEmployeeScreen = "SearchEmployeeScreen";
  static const String historyScreen = "historyScreen";

  static Map<String, Widget Function(BuildContext)> appRoutes = {
    splashScreen: (context) => SplashScreen(),
    homeScreen: (context) => HomeScreen(),
    deviceDetailsScreen: (context) => DeviceDetailsScreen(),
    searchEmployeeScreen: (context) => SearchEmployeeScreen(),
    historyScreen: (context) => HistoryScreen()
  };
}
