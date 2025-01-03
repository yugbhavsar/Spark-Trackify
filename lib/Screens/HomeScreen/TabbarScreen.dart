import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spark_trackify/Screens/AssignDetailScreen/AssignDetailScreen.dart';
import 'package:spark_trackify/Screens/HomeScreen/Cubit/tabbar_cubit.dart';
import 'package:spark_trackify/Screens/HomeScreen/DeviceListingScreen.dart';
import 'package:spark_trackify/Utilities/Constants.dart';
import 'package:spark_trackify/Utilities/ThemeColors.dart';
import 'package:spark_trackify/main.dart';

class TabBarScreen extends StatelessWidget {

  const TabBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        bottom: false,
        child: BlocBuilder<TabbarCubit,TabbarState>(builder: (context, state) {
          var selectedIndex = 0;
          if (state is TabbarInitial) {
            selectedIndex = state.selectedTab;
          }else{
            selectedIndex = 0;
          }
          return Scaffold(
              bottomNavigationBar: Container(
                height: 80,
                margin: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                ),
                child: Card(
                  color: Colors.white,
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: const BorderSide(width: 0,color: Colors.transparent)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: (){
                          context.read<TabbarCubit>().tabBarClick(0);
                        },
                        child: Container(
                          height: 50,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: selectedIndex == 0 ? AppColors.primaryGreen:Colors.white
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(AppImages.gadgets, fit: BoxFit.fill,
                                height: 30,
                                color: selectedIndex == 0 ? Colors.white:Colors.grey,),

                              const SizedBox(width: 10,),

                              Text("Devices", style: appTextStyle(
                                  textColor: selectedIndex == 0 ? Colors.white:Colors.grey,
                                  style: FontStyle.semibold,
                                  fontSize: 18),)
                            ],
                          ),
                        ),
                      ),
                      
                  
                      GestureDetector(
                        onTap: (){
                          context.read<TabbarCubit>().tabBarClick(2);
                        },
                        child: Container(
                          height: 50,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: selectedIndex != 0 ? AppColors.primaryGreen:Colors.white
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(AppImages.assign, fit: BoxFit.fill,
                                height: 40,
                                color: selectedIndex != 0 ? Colors.white:Colors.grey,),

                              const SizedBox(width: 10,),

                              Text("Assign", style: appTextStyle(
                                  textColor: selectedIndex != 0 ? Colors.white:Colors.grey,
                                  style: FontStyle.semibold,
                                  fontSize: 18),)
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              body: selectedIndex == 0 ? DeviceListingScreen():const AssignDetailScreen(isForAssign: true,)
          );
        })
    );
  }
}
