import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spark_trackify/Screens/SplashScreen/Cubit/splash_screen_cubit.dart';
import 'package:spark_trackify/Utilities/Constants.dart';
import 'package:spark_trackify/Utilities/Routes.dart';

import '../LoginScreen/LoginScreen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    context.read<SplashScreenCubit>().authenticate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<SplashScreenCubit, SplashScreenState>(
        listener: (context, state) {
          if (state is SplashScreenInitial) {
            if (state.navigate == SplashToNavigate.loginScreen) {
              Navigator.pushNamedAndRemoveUntil(context, RouteName.loginScreen,(route) => false,);
            }else if ( state.navigate == SplashToNavigate.homeScreen ) {
              Navigator.pushNamedAndRemoveUntil(context, RouteName.deviceListingScreen,(route) => false,);
            }
          }
        },
        child: Center(
          child: Hero(
              tag: "eSparkLogo",
              child: SvgPicture.asset(
                AppImages.eSparkIcon, fit: BoxFit.fill, height: 55,)
          ),
        ),
      )
    );
  }
}

