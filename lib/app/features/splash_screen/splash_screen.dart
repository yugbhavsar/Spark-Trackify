import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spark_trackify/app/routes/app_routes.dart';

import '../../../gen/assets.gen.dart';
import '../../data/utils/app_preference.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.homeScreen, (route) => false);
    });

    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((timeStamp) async {
      await AppPreference.instance.init();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Hero(
            tag: "eSparkLogo",
            child: SvgPicture.asset(
              Assets.svgs.eSparkLogo.path,
              fit: BoxFit.fill,
              height: 55,
            )),
      ),
    );
  }
}
