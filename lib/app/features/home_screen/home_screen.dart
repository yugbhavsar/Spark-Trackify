import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spark_trackify/app/core/common/ThemeColors.dart';
import 'package:spark_trackify/app/features/home_screen/cubit/home_cubit.dart';
import 'package:spark_trackify/gen/assets.gen.dart';

import '../AssignDetailScreen/AssignDetailScreen.dart';
import 'device_listing_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    context.read<HomeCubit>().fetchDeviceData();
    tabController.addListener(() {
      context.read<HomeCubit>().tabBarClick(tabController.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      top: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: TabBarView(controller: tabController, children: [
          DeviceListingScreen(),
          AssignDetailScreen(isForAssign: true),
        ]),
        bottomNavigationBar: Container(
          height: 75,
          margin: EdgeInsets.only(bottom: 16, left: 16, right: 16, top: 6),
          padding: EdgeInsets.zero,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                offset: Offset(0, 2),
                blurRadius: 3,
                spreadRadius: .5,
              ),
            ],
          ),
          child: BlocBuilder<HomeCubit, HomeState>(
            buildWhen: (previous, current) => previous.selectedTab != current.selectedTab,
            builder: (context, state) {
              int selectedTab = state.selectedTab;
              return TabBar(
                  controller: tabController,
                  padding: EdgeInsets.zero,
                  dividerHeight: 0,
                  splashBorderRadius: BorderRadius.circular(50),
                  indicator: BoxDecoration(
                    color: AppColors.primaryGreen,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  unselectedLabelColor: Colors.white,
                  labelStyle: appTextStyle(textColor: Colors.white, style: FontStyle.semibold, fontSize: 18),
                  unselectedLabelStyle: appTextStyle(textColor: Colors.grey, style: FontStyle.semibold, fontSize: 18),
                  indicatorPadding: EdgeInsets.symmetric(vertical: 12),
                  tabs: [
                    _buildTab(
                        label: "Devices",
                        image: Assets.images.gadgets.image(
                          fit: BoxFit.fill,
                          height: 32,
                          width: 32,
                          color: selectedTab == 0 ? Colors.white : Colors.grey,
                        ),
                        isSelected: selectedTab == 0),
                    _buildTab(
                        label: "Assign",
                        image: Assets.images.assign.image(
                          fit: BoxFit.fill,
                          height: 32,
                          width: 32,
                          color: selectedTab == 1 ? Colors.white : Colors.grey,
                        ),
                        isSelected: selectedTab == 1)
                  ]);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTab({
    required String label,
    required Image image,
    required bool isSelected,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        image,
        const SizedBox(width: 10),
        Text(
          label,
          style: appTextStyle(
            textColor: isSelected ? Colors.white : Colors.grey,
            style: FontStyle.semibold,
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}
