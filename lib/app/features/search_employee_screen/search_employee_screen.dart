import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spark_trackify/app/core/extensions/extensions.dart';
import 'package:spark_trackify/app/features/home_screen/models/employee_model.dart';
import 'package:spark_trackify/app/widgets/base_imageview.dart';

import '../../../gen/assets.gen.dart';
import '../../core/common/ThemeColors.dart';
import '../../widgets/base_textfield.dart';
import '../home_screen/cubit/home_cubit.dart';

class SearchEmployeeScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  Timer? timer;

  SearchEmployeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    Assets.images.backArrow.path,
                    fit: BoxFit.fill,
                    height: 30,
                    width: 30,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  "Search Employee",
                  style: appTextStyle(textColor: AppColors.darkColor, fontSize: 22, style: FontStyle.semibold),
                ),
              ],
            ),
            SizedBox(height: 20),
            BaseTextField(
              controller: _controller,
              placeholder: "Search Employee Name",
              onChanged: (value) {
                timer?.cancel();
                timer = Timer(Duration(milliseconds: 400), () {
                  context.read<HomeCubit>().filterEmployees(query: value);
                });
              },
            ),
            SizedBox(height: 12),
            Expanded(
              child: BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  return ListView.builder(
                    padding: EdgeInsets.all(1),
                    itemBuilder: (context, index) {
                      EmployeeModel employeeModel = state.filteredEmployeeList[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.pop(
                              context, {"name": "${employeeModel.firstname} ${employeeModel.lastname}", "id": employeeModel.id});
                        },
                        child: EmployeeCardView(
                          profileImage: employeeModel.profileImage,
                          department: employeeModel.departmentname,
                          fullName: "${employeeModel.firstname} ${employeeModel.lastname}",
                        ),
                      );
                    },
                    itemCount: state.filteredEmployeeList.length,
                  );
                },
              ),
            )
          ],
        ),
      )),
    );
  }
}

class EmployeeCardView extends StatelessWidget {
  final String? profileImage;
  final String? fullName;
  final String? department;

  const EmployeeCardView({super.key, required this.profileImage, this.department, this.fullName});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      color: Colors.white,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: BaseImageView(
                  width: 60, height: 60, imageUrl: profileImage ?? "", nameLetters: "$fullName".getFirstTwoWordInitials()),
            ),
            SizedBox(width: 12),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "$fullName",
                  style: appTextStyle(textColor: AppColors.darkColor, fontSize: 20, style: FontStyle.semibold),
                ),
                SizedBox(height: 8),
                Text(
                  department ?? "",
                  style: appTextStyle(textColor: AppColors.darkColor, fontSize: 14, style: FontStyle.regular),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
