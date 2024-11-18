import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spark_trackify/app/core/common/ThemeColors.dart';
import 'package:spark_trackify/app/core/enums/app_enum.dart';
import 'package:spark_trackify/app/data/utils/app_preference.dart';
import 'package:spark_trackify/app/features/LoginScreen/bloc/login_bloc.dart';
import 'package:spark_trackify/app/routes/app_routes.dart';
import 'package:spark_trackify/app/widgets/app_loader.dart';
import 'package:spark_trackify/app/widgets/base_button.dart';
import 'package:spark_trackify/app/widgets/show_toast.dart';

import '../../../gen/assets.gen.dart';
import '../../widgets/base_textfield.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController userField = TextEditingController();

  final TextEditingController passwordField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.darkColor,
        body: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state.activeStatus == ActiveStatus.action) {
              if (AppPreference.instance.getToken().isNotEmpty) {
                Navigator.pushNamedAndRemoveUntil(context, AppRoutes.tabBarScreen, (route) => false);
              } else {
                showToast.setMsg("Something went wrong!.");
              }
            }
          },
          child: Stack(children: [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.30,
                    width: double.infinity,
                    child: Center(
                      child: Hero(
                          tag: "eSparkLogo",
                          child: Image.asset(
                            Assets.images.eSparkBiz.path,
                            fit: BoxFit.fill,
                            height: 60,
                          )),
                    ),
                  ),
                  Container(
                    height: MediaQuery.sizeOf(context).height * 0.70,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25))),
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 50),
                        Text(
                          "Login",
                          style: appTextStyle(style: FontStyle.bold),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Sign In to your account",
                          style: appTextStyle(fontSize: 18, style: FontStyle.regular),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          height: 50,
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)), color: AppColors.lightBackground),
                          child: CustomTextField(
                            controller: userField,
                            placeholder: "Enter Employee Id",
                            prefixIcon: Assets.images.user.path,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          height: 50,
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)), color: AppColors.lightBackground),
                          child: CustomTextField(
                            controller: passwordField,
                            placeholder: "Password",
                            prefixIcon: Assets.images.padlock.path,
                          ),
                        ),
                        Spacer(),
                        BaseButton(
                          label: "Login",
                          borderRadius: BorderRadius.circular(12),
                          onClick: () {
                            context
                                .read<LoginBloc>()
                                .add(LoginRequestedEvent(email: userField.text.trim(), password: passwordField.text.trim()));
                          },
                        ),
                        const SizedBox(height: 50),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            BlocBuilder<LoginBloc, LoginState>(
              buildWhen: (previous, current) => previous.isLoading != current.isLoading,
              builder: (context, state) {
                if (state.isLoading) {
                  return AppLoader();
                } else {
                  return SizedBox();
                }
              },
            )
          ]),
        ));
  }
}
