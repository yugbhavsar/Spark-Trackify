import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:spark_trackify/app/features/AssignDetailScreen/repository/assignDetailsRepository.dart';
import 'package:spark_trackify/app/features/LoginScreen/repository/loginRepository.dart';
import 'package:spark_trackify/app/routes/app_routes.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  await setUP();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
            create: (context) => LoginRepository(),
          ),
          RepositoryProvider(
            create: (context) => AssignDetailsRepository(),
          )
        ],
        child: MaterialApp(
          title: "eSpark Trackify",
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoutes.splashScreen,
          routes: AppRoutes.appRoutes,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
            scaffoldBackgroundColor: Colors.white,
          ),
        ),
      ),
    );
  }
}

Future<void> setUP() async {
  if (Platform.isAndroid) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: dotenv.get("API_KEY", fallback: ""),
            appId: dotenv.get("APP_ID", fallback: ""),
            messagingSenderId: dotenv.get("MESSAGING_ID", fallback: ""),
            projectId: dotenv.get("PROJECT_ID", fallback: "")));
  } else if (Platform.isIOS) {
    await Firebase.initializeApp();
  }
}
