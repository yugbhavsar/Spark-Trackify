import 'package:flutter/material.dart';
import 'package:spark_trackify/app/core/common/ThemeColors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String placeholder;
  final int maxLength;

  final String prefixIcon;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.placeholder,
    this.maxLength = 50,
    this.prefixIcon = "",
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          hintText: placeholder,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.primaryGreen, // Border color when focused
              width: 2.0, // Border width
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent, width: 0.0)),
          prefixIcon: (prefixIcon != "")
              ? SizedBox(
                  height: 40,
                  width: 40,
                  child: Image.asset(
                    prefixIcon,
                    height: 25,
                    width: 25,
                  ),
                )
              : const SizedBox(
                  height: 0,
                  width: 10,
                ),
          prefixIconConstraints: BoxConstraints(maxHeight: (prefixIcon != "") ? 25 : 10)),
    );
  }
}
