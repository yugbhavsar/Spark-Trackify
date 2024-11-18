import 'package:flutter/material.dart';

import '../core/common/ThemeColors.dart';

class BaseButton extends StatelessWidget {
  const BaseButton(
      {super.key,
      this.label,
      this.onClick,
      this.borderRadius,
      this.color,
      this.suffixIcon,
      this.prefixIcon,
      this.textStyle,
      this.height = 50,
      this.width = double.infinity,
      this.expandedTitle = false,
      this.padding});

  final String? label;
  final VoidCallback? onClick;
  final BorderRadiusGeometry? borderRadius;
  final Color? color;
  final TextStyle? textStyle;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final double? height, width;
  final EdgeInsetsGeometry? padding;
  final bool expandedTitle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        height: height,
        width: width,
        padding: padding ?? EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration:
            BoxDecoration(borderRadius: borderRadius ?? BorderRadius.circular(6), color: color ?? AppColors.primaryGreen, boxShadow: [
          if (color != Colors.transparent) ...[
            BoxShadow(color: AppColors.primaryGreen.withOpacity(.03), spreadRadius: 0, offset: const Offset(0, 3), blurRadius: 6)
          ],
        ]),
        child: Center(
            child: IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (prefixIcon != null) ...[
                prefixIcon!,
                SizedBox(
                  width: 8,
                ),
              ],
              if (label != null) ...[
                (expandedTitle)
                    ? Expanded(
                        child: Text(
                          overflow: TextOverflow.ellipsis,
                          label!,
                          style: textStyle ?? appTextStyle(style: FontStyle.semibold, fontSize: 20, textColor: Colors.white),
                        ),
                      )
                    : Text(
                        overflow: TextOverflow.ellipsis,
                        label!,
                        style: textStyle ?? appTextStyle(style: FontStyle.semibold, fontSize: 20, textColor: Colors.white),
                      ),
              ],
              if (suffixIcon != null) ...[SizedBox(width: 8), suffixIcon!],
            ],
          ),
        )),
      ),
    );
  }
}
