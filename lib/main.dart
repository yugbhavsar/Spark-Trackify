import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:spark_trackify/Utilities/Routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setUP();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        title: "Espark Teckify",
        debugShowCheckedModeBanner: false,
        initialRoute: RouteName.splashScreen,
        onGenerateRoute: AppRoutes.generateRoute);
  }
}

Future<void> setUP() async {
  if (Platform.isAndroid) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyBTYnQ8ZUNaFBjUsR1az-0YgQkqVI1hc5Q",
            appId: "1:501373164474:android:1e3387a193dc453be45b83",
            messagingSenderId: "501373164474",
            projectId: "espark-trackify"));
  } else if (Platform.isIOS) {
    await Firebase.initializeApp();
  }
}
