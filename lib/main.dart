import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spark_trackify/Repository/APIHelper.dart';
import 'package:spark_trackify/Screens/SplashScreen/Cubit/splash_screen_cubit.dart';
import 'package:spark_trackify/Utilities/Routes.dart';
import 'package:firebase_core/firebase_core.dart';


void main() {

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  const MaterialApp(
          title: "Espark Teckify",
          debugShowCheckedModeBanner: false,
          initialRoute: RouteName.splashScreen,
          onGenerateRoute: AppRoutes.generateRoute
    );
  }
}


Future<void> setUP() async {
  if (Platform.isIOS) {
    await Firebase.initializeApp();
  }
}
