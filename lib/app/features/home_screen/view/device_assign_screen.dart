import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spark_trackify/app/core/common/ThemeColors.dart';
import 'package:spark_trackify/app/features/home_screen/models/device_info_model.dart';
import 'package:spark_trackify/app/routes/app_routes.dart';
import 'package:spark_trackify/app/widgets/base_button.dart';
import 'package:spark_trackify/app/widgets/base_textfield.dart';
import 'package:spark_trackify/gen/assets.gen.dart';

import '../../../core/enums/app_enum.dart';
import '../cubit/home_cubit.dart';

class DeviceAssignScreen extends StatelessWidget {
  DeviceAssignScreen(
      {super.key,
      this.deviceInfoModel,
      required this.employeeNameController,
      required this.noteController,
      required this.deviceAssignForGroupValue,
      required this.deviceImage});

  final DeviceInfoModel? deviceInfoModel;
  final TextEditingController employeeNameController;
  final TextEditingController noteController;
  final DeviceAssignFor deviceAssignForGroupValue;
  final String deviceImage;

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
              Text(
                textAlign: TextAlign.center,
                deviceInfoModel?.modelName ?? "",
                style: appTextStyle(textColor: AppColors.darkColor, fontSize: 24, style: FontStyle.semibold),
              ),
              const SizedBox(
                height: 16,
              ),
              Center(
                child: CachedNetworkImage(
                  imageUrl: deviceImage,
                  height: 300,
                  fit: BoxFit.fitHeight,
                  errorWidget: (context, url, error) => Assets.phones.phone.image(),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                "Assign To : ",
                style: appTextStyle(textColor: Colors.black, fontSize: 18, style: FontStyle.medium),
              ),
              SizedBox(height: 8),
              BaseTextField(
                controller: employeeNameController,
                placeholder: "Employee Name",
                readOnly: true,
                onTap: () async {
                  var args = await Navigator.pushNamed(context, AppRoutes.searchEmployeeScreen);
                  if (args != null) {
                    Map? map = args as Map?;
                    employeeNameController.text = map?["name"] ?? "";
                    context.read<HomeCubit>().selectedAssignInfo(map?["id"]);
                  }
                },
              ),
              SizedBox(height: 20),
              Text(
                "Assign For : ",
                style: appTextStyle(textColor: Colors.black, fontSize: 18, style: FontStyle.medium),
              ),
              SizedBox(height: 8),
              Column(
                  children: DeviceAssignFor.values.map(
                (e) {
                  return RadioListTile(
                    visualDensity: VisualDensity(horizontal: -4),
                    contentPadding: EdgeInsets.zero,
                    value: e,
                    activeColor: AppColors.btnGreen,
                    groupValue: deviceAssignForGroupValue,
                    onChanged: (value) {
                      context.read<HomeCubit>().assignForSelection(value ?? DeviceAssignFor.development);
                    },
                    title: Text(
                      e.name,
                      style: appTextStyle(textColor: Colors.black, fontSize: 18, style: FontStyle.semibold),
                    ),
                  );
                },
              ).toList()),
              SizedBox(height: 16),
              Text(
                "Note : ",
                style: appTextStyle(textColor: Colors.black, fontSize: 18, style: FontStyle.medium),
              ),
              SizedBox(height: 8),
              BaseTextField(
                controller: noteController,
                placeholder: "Note...",
                maxLines: 3,
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
