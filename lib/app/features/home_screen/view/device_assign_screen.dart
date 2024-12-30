import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spark_trackify/app/core/common/ThemeColors.dart';
import 'package:spark_trackify/app/data/utils/app_utils.dart';
import 'package:spark_trackify/app/routes/app_routes.dart';
import 'package:spark_trackify/app/widgets/base_button.dart';
import 'package:spark_trackify/app/widgets/base_textfield.dart';

import '../../../core/enums/app_enum.dart';
import '../cubit/home_cubit.dart';

class DeviceAssignScreen extends StatefulWidget {
  DeviceAssignScreen({
    super.key,
  });

  @override
  State<DeviceAssignScreen> createState() => _DeviceAssignScreenState();
}

class _DeviceAssignScreenState extends State<DeviceAssignScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().getDeviceInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        physics: const ScrollPhysics(parent: BouncingScrollPhysics()),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 16,
              ),
              BlocBuilder<HomeCubit, HomeState>(
                buildWhen: (previous, current) => previous.deviceInfoModel != current.deviceInfoModel,
                builder: (context, state) {
                  return Text(
                    textAlign: TextAlign.center,
                    state.deviceInfoModel?.deviceName ?? "",
                    style: appTextStyle(textColor: AppColors.darkColor, fontSize: 24, style: FontStyle.semibold),
                  );
                },
              ),
              const SizedBox(
                height: 16,
              ),
              BlocBuilder<HomeCubit, HomeState>(
                buildWhen: (previous, current) => previous.deviceInfoModel != current.deviceInfoModel,
                builder: (context, state) {
                  return Center(
                    child: Image.asset(AppUtils.getDeviceImage(modelName: state.deviceInfoModel?.modelName ?? ""),
                        fit: BoxFit.fitHeight, height: 300),
                  );
                },
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                "Assign To : ",
                style: appTextStyle(textColor: Colors.black, fontSize: 18, style: FontStyle.medium),
              ),
              SizedBox(height: 8),
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  return BaseTextField(
                    controller: state.employeeNameController,
                    placeholder: "Employee Name",
                    readOnly: true,
                    onTap: () async {
                      var args = await Navigator.pushNamed(context, AppRoutes.searchEmployeeScreen);
                      if (args != null) {
                        Map? map = args as Map?;
                        state.employeeNameController.text = map?["name"] ?? "";
                        context.read<HomeCubit>().selectedAssignInfo(map?["id"]);
                      }
                    },
                  );
                },
              ),
              SizedBox(height: 20),
              Text(
                "Assign For : ",
                style: appTextStyle(textColor: Colors.black, fontSize: 18, style: FontStyle.medium),
              ),
              SizedBox(height: 8),
              BlocBuilder<HomeCubit, HomeState>(
                buildWhen: (previous, current) => previous.deviceAssignForGroupValue != current.deviceAssignForGroupValue,
                builder: (context, state) {
                  return Column(
                      children: DeviceAssignFor.values.map(
                    (e) {
                      return RadioListTile(
                        visualDensity: VisualDensity(horizontal: -4),
                        contentPadding: EdgeInsets.zero,
                        value: e,
                        activeColor: AppColors.btnGreen,
                        groupValue: state.deviceAssignForGroupValue,
                        onChanged: (value) {
                          context.read<HomeCubit>().assignForSelection(value ?? DeviceAssignFor.development);
                        },
                        title: Text(
                          e.name,
                          style: appTextStyle(textColor: Colors.black, fontSize: 18, style: FontStyle.semibold),
                        ),
                      );
                    },
                  ).toList());
                },
              ),
              SizedBox(height: 16),
              Text(
                "Note : ",
                style: appTextStyle(textColor: Colors.black, fontSize: 18, style: FontStyle.medium),
              ),
              SizedBox(height: 8),
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  return BaseTextField(
                    controller: state.noteController,
                    placeholder: "Note...",
                    maxLines: 3,
                  );
                },
              ),
              SizedBox(height: 20),
              BaseButton(
                label: "Assign",
                onClick: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  context.read<HomeCubit>().assignDevice();
                },
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      )),
    );
  }
}
