import 'package:flutter/material.dart';

import '../../../gen/assets.gen.dart';
import '../../core/common/ThemeColors.dart';
import '../../widgets/base_textfield.dart';

class SearchEmployeeScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  SearchEmployeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.lightBackground, width: 3, style: BorderStyle.solid)),
            child: CustomTextField(controller: _controller, placeholder: "Search Employee To Assign"),
          ),
        ],
      )),
    );
  }
}
