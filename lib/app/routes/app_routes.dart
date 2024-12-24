import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../features/AssignDetailScreen/AssignDetailScreen.dart';
import '../features/home_screen/cubit/home_cubit.dart';
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
    homeScreen: (context) => BlocProvider(
          create: (context) => HomeCubit(),
          child: HomeScreen(),
        ),
    assignDetailScreen: (context) => AssignDetailScreen(),
    searchEmployeeScreen: (context) => SearchEmployeeScreen()
  };
}
