import 'package:flutter/material.dart';
import 'package:spark_trackify/app/core/common/ThemeColors.dart';

class BaseTextField extends StatelessWidget {
  final TextEditingController controller;
  final String placeholder;
  final int maxLength;
  final int? maxLines;
  final bool readOnly;
  final String prefixIcon;
  final void Function()? onTap;
  final void Function(String)? onChanged;

  const BaseTextField({
    super.key,
    required this.controller,
    required this.placeholder,
    this.maxLength = 50,
    this.maxLines,
    this.onTap,
    this.onChanged,
    this.readOnly = false,
    this.prefixIcon = "",
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: onTap,
      onChanged: onChanged,
      controller: controller,
      readOnly: readOnly,
      maxLines: maxLines,
      style: appTextStyle(textColor: Colors.black, fontSize: 18, style: FontStyle.medium),
      cursorColor: AppColors.primaryGreen,
      decoration: InputDecoration(
          hintText: placeholder,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.lightBackground, // Border color when focused
              width: 3, // Border width
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.lightBackground, width: 3), borderRadius: BorderRadius.circular(12)),
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
