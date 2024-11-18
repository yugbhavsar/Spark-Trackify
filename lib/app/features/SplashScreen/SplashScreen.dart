import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spark_trackify/app/routes/app_routes.dart';

import '../../../gen/assets.gen.dart';
import '../../data/utils/app_preference.dart';
import 'Cubit/splash_screen_cubit.dart';

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
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((timeStamp) async {
      await AppPreference.instance.init();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: BlocListener<SplashScreenCubit, SplashScreenState>(
          listener: (context, state) {
            if (state is SplashScreenInitial) {
              if (state.navigate == SplashToNavigate.loginScreen) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.loginScreen,
                  (route) => false,
                );
              } else if (state.navigate == SplashToNavigate.homeScreen) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.deviceListingScreen,
                  (route) => false,
                );
              }
            }
          },
          child: Center(
            child: Hero(
                tag: "eSparkLogo",
                child: SvgPicture.asset(
                  Assets.images.eSparkLogo.path,
                  fit: BoxFit.fill,
                  height: 55,
                )),
          ),
        ));
  }
}
