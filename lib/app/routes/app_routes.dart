import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spark_trackify/app/features/AssignDetailScreen/bloc/assign_details_bloc.dart';
import 'package:spark_trackify/app/features/AssignDetailScreen/repository/assignDetailsRepository.dart';
import 'package:spark_trackify/app/features/HomeScreen/Cubit/tabbar_cubit.dart';
import 'package:spark_trackify/app/features/LoginScreen/bloc/login_bloc.dart';
import 'package:spark_trackify/app/features/LoginScreen/repository/loginRepository.dart';
import 'package:spark_trackify/app/features/SplashScreen/Cubit/splash_screen_cubit.dart';

import '../features/AssignDetailScreen/AssignDetailScreen.dart';
import '../features/HomeScreen/DeviceListingScreen.dart';
import '../features/HomeScreen/TabbarScreen.dart';
import '../features/LoginScreen/LoginScreen.dart';
import '../features/SearchEmployeeScreen/SearchEmployeeScreen.dart';
import '../features/SplashScreen/SplashScreen.dart';

class AppRoutes {
  static const String splashScreen = "SplashScreen";
  static const String loginScreen = "loginScreen";
  static const String tabBarScreen = "TabBarScreen";
  static const String deviceListingScreen = "DeviceListingScreen";
  static const String assignDetailScreen = "AssignDetailScreen";
  static const String searchEmployeeScreen = "SearchEmployeeScreen";

  static Map<String, Widget Function(BuildContext)> appRoutes = {
    splashScreen: (context) => BlocProvider(
          create: (context) => SplashScreenCubit(),
          child: SplashScreen(),
        ),
    loginScreen: (context) => BlocProvider(
          create: (context) => LoginBloc(loginRepository: context.read<LoginRepository>()),
          child: LoginScreen(),
        ),
    deviceListingScreen: (context) => DeviceListingScreen(),
    tabBarScreen: (context) => BlocProvider(
          create: (context) => TabbarCubit(),
          child: TabBarScreen(),
        ),
    assignDetailScreen: (context) => BlocProvider(
          create: (context) => AssignDetailsBloc(assignDetailsRepository: context.read<AssignDetailsRepository>()),
          child: AssignDetailScreen(),
        ),
    searchEmployeeScreen: (context) => SearchEmployeeScreen()
  };
}
