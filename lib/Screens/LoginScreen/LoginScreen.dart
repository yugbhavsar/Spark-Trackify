import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spark_trackify/Utilities/Constants.dart';
import 'package:spark_trackify/Utilities/Routes.dart';
import 'package:spark_trackify/Utilities/ThemeColors.dart';

import '../../Utilities/CommanWidgets.dart';


class LoginScreen extends StatelessWidget {

  LoginScreen({super.key});

  final TextEditingController userField = TextEditingController();
  final FocusNode userFieldNode = FocusNode();

  final TextEditingController passwordField = TextEditingController();
  final FocusNode passwordFieldNode = FocusNode();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [

          SizedBox(
            height: MediaQuery.sizeOf(context).height*0.30,
            width: double.infinity,
            child: Center(
              child: Hero(
                  tag: "eSparkLogo",
                  child: Image.asset(AppImages.eSparkWhiteIcon,fit: BoxFit.fill, height: 60,)
              ),
            ),
          ),

          Container(
            height: MediaQuery.sizeOf(context).height*0.70,
            width: double.infinity,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25) ,
                    topRight:Radius.circular(25)
                )
            ),
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const SizedBox(height: 50),

                Text("Login",style: appTextStyle(style: FontStyle.bold),),

                const SizedBox(height: 10),

                Text("Sign In to your account",style: appTextStyle(fontSize: 18,style: FontStyle.regular),),

                const SizedBox(height: 20),

                Container(
                  height: 50,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: AppColors.lightBackground
                  ),
                  child: CustomTextField(
                    controller: userField,
                    focusNode: userFieldNode,
                    placeholder: "Enter Employee Id",
                    prefixIcon: AppImages.userIcon,
                  ),
                ),

                const SizedBox(height: 20),

                Container(
                  height: 50,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: AppColors.lightBackground
                  ),
                  child: CustomTextField(
                    controller: passwordField,
                    focusNode: passwordFieldNode,
                    placeholder: "Password",
                    prefixIcon: AppImages.passwordLockIcon,
                  ),
                ),

                const Expanded(child: SizedBox()),

                ElevatedButton(
                    onPressed: (){
                      Navigator.pushNamed(context, RouteName.tabBarScreen);
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        backgroundColor: AppColors.btnGreen
                    ),
                    child: SizedBox(
                      height: 50,
                        child: Center(child: Text("Login", style: appTextStyle(fontSize: 18 , style: FontStyle.semibold , textColor: Colors.white),))
                    )
                ),

                const SizedBox(height: 50),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
