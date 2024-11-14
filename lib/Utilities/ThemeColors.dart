import 'dart:ui';
import 'package:flutter/material.dart';

class AppColors {

  static const Color darkColor = Color(0xFF04121f);
  static const Color primaryGreen = Color(0xFF067a46);
  static const Color btnGreen = Color(0xFF067a46);
  static const Color lightBackground = Color(0xFFE8F0FE);

}


TextStyle appTextStyle({Color textColor = AppColors.darkColor , double fontSize = 24 , FontStyle style = FontStyle.semibold}) {
  return TextStyle(
    color: textColor,
    fontSize: fontSize,
    fontWeight: getFontStyle(style),
    fontFamily: "RobotoMono-VariableFont_wght",
  );
}

FontWeight getFontStyle(FontStyle style ){

  switch (style) {
    case FontStyle.regular :
      return FontWeight.w300;
    case FontStyle.medium:
      return FontWeight.w500;
    case FontStyle.semibold:
      return FontWeight.w700;
    case FontStyle.bold:
      return FontWeight.w900;
  }

}

enum FontStyle {
  regular,
  medium,
  semibold,
  bold
}