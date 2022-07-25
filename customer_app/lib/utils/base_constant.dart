import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Constant {
  static const APP_FONT_FAMILY = "Inter";
}

ThemeData baseTheme() {
  final ThemeData base = ThemeData(
    fontFamily: Constant.APP_FONT_FAMILY,
    backgroundColor: Colors.white,
    dividerColor: BaseColor.hint,
    errorColor: BaseColor.error,
    focusColor: BaseColor.primary,
    hintColor: BaseColor.hint,
    primaryColor: BaseColor.primary,
  );
  return base;
}

class BaseColor {
  static const Color primary = Color(0xFF003399);
  static const Color error = Color(0xFFD43513);
  static const Color secondary = Color(0xFFFF9900);
  static const Color hint = Color(0xFFA3A3A3);
  static const Color greyBackground = Color(0xFFF3F3F3);
  static const Color connect = Color(0xFF00C11F);
  static const Color off = Color(0xFFC3CAE9);
}

class BaseTextStyle {
  static TextStyle fontFamilyLight(Color textColor, double fontSize) {
    return TextStyle(
        fontFamily: "${Constant.APP_FONT_FAMILY}-Light",
        fontSize: fontSize,
        height: 1.46,
        color: textColor,
        fontWeight: FontWeight.w400);
  }

  static TextStyle fontFamilyRegular(Color textColor, double fontSize) {
    return TextStyle(
        fontFamily: "${Constant.APP_FONT_FAMILY}-Regular",
        fontSize: fontSize,
        color: textColor,
        fontWeight: FontWeight.w400);
  }

  static TextStyle fontFamilyMedium(Color textColor, double fontSize) {
    return TextStyle(
        fontFamily: "${Constant.APP_FONT_FAMILY}-Medium",
        fontSize: fontSize,
        color: textColor,
        fontWeight: FontWeight.w500);
  }

  static TextStyle fontFamilySemiBold(Color textColor, double fontSize) {
    return TextStyle(
        fontFamily: "${Constant.APP_FONT_FAMILY}-SemiBold",
        fontSize: fontSize,
        color: textColor,
        fontWeight: FontWeight.w600);
  }

  static TextStyle fontFamilyBold(Color textColor, double fontSize) {
    return TextStyle(
        fontFamily: "${Constant.APP_FONT_FAMILY}-Bold",
        fontSize: fontSize,
        color: textColor,
        fontWeight: FontWeight.w700);
  }
}
