import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spark_trackify/Screens/HomeScreen/Cubit/tabbar_cubit.dart';
import 'package:spark_trackify/Screens/HomeScreen/DeviceListingScreen.dart';
import 'package:spark_trackify/Screens/HomeScreen/TabbarScreen.dart';
import 'package:spark_trackify/Screens/SearchEmployeeScreen/SearchEmployeeScreen.dart';
import 'package:spark_trackify/Screens/SplashScreen/SplashScreen.dart';
import '../Screens/LoginScreen/LoginScreen.dart';
import '../Screens/AssignDetailScreen/AssignDetailScreen.dart';
import '../Screens/SplashScreen/Cubit/splash_screen_cubit.dart';


class RouteName {

  static const String loginScreen = "loginScreen";
  static const String deviceListingScreen = "DeviceListingScreen";
  static const String assignDetailScreen = "AssignDetailScreen";
  static const String splashScreen = "SplashScreen";
  static const String tabBarScreen = "TabBarScreen";
  static const String searchEmployeeScreen = "SearchEmployeeScreen";

}


class AppRoutes {

  static Route<dynamic> generateRoute(RouteSettings setting) {

    switch (setting.name) {

      case RouteName.deviceListingScreen:
        return MaterialPageRoute(builder: (context) => DeviceListingScreen(),settings: const RouteSettings(name: RouteName.deviceListingScreen));

      case RouteName.loginScreen:
        return MaterialPageRoute(builder: (context) => LoginScreen(),settings: const RouteSettings(name: RouteName.loginScreen));

      case RouteName.assignDetailScreen:
        return MaterialPageRoute(builder: (context) => const AssignDetailScreen(isForAssign: false,),settings: const RouteSettings(name: RouteName.assignDetailScreen));

      case RouteName.splashScreen:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => SplashScreenCubit(),
              child: const SplashScreen(),
            ),
            settings: const RouteSettings(name: RouteName.splashScreen)
        );

      case RouteName.tabBarScreen:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => TabbarCubit(),
              child: const TabBarScreen(),
            ),
            settings: const RouteSettings(name: RouteName.tabBarScreen));

      case RouteName.searchEmployeeScreen:
        return MaterialPageRoute(
            builder: (context) =>  SearchEmployeeScreen(),
            settings: const RouteSettings(name: RouteName.searchEmployeeScreen)
        );

      default:
        return MaterialPageRoute(builder: (context) => LoginScreen(),settings: const RouteSettings(name: RouteName.loginScreen));

    }
  }
}