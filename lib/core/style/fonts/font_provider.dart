import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FontsProvider {
  static const _latin = 'Plus Jakarta Sans';
  static const _arabic = 'Cairo';

  static TextStyle _style(
      bool isArabic,
      double size,
      FontWeight weight, {
        double letterSpacing = 0,
        Color? color,
      }) =>
      GoogleFonts.getFont(
        isArabic ? _arabic : _latin,
        textStyle: TextStyle(
          fontSize: size,
          fontWeight: weight,
          letterSpacing: isArabic ? 0 : letterSpacing,
          color: color,
        ),
      );

  static TextStyle getHeadline1TextStyle({required bool isArabic, Color? color}) =>
      _style(isArabic, 96, FontWeight.w300, letterSpacing: -1.5, color: color);

  static TextStyle getHeadline2TextStyle({required bool isArabic, Color? color}) =>
      _style(isArabic, 60, FontWeight.w300, letterSpacing: -0.5, color: color);

  static TextStyle getHeadline3TextStyle({required bool isArabic, Color? color}) =>
      _style(isArabic, 48, FontWeight.w400, color: color);

  static TextStyle getHeadline4TextStyle({required bool isArabic, Color? color}) =>
      _style(isArabic, 34, FontWeight.w600, letterSpacing: 0.25, color: color);

  static TextStyle getHeadline5TextStyle({required bool isArabic, Color? color}) =>
      _style(isArabic, 24, FontWeight.w700, color: color);

  static TextStyle getHeadline6TextStyle({required bool isArabic, Color? color}) =>
      _style(isArabic, 20, FontWeight.w600, letterSpacing: 0.15, color: color);

  static TextStyle getSubtitle1TextStyle({required bool isArabic, Color? color}) =>
      _style(isArabic, 16, FontWeight.w500, letterSpacing: 0.15, color: color);

  static TextStyle getSubtitle2TextStyle({required bool isArabic, Color? color}) =>
      _style(isArabic, 14, FontWeight.w600, letterSpacing: 0.1, color: color);

  static TextStyle getBody1TextStyle({required bool isArabic, Color? color}) =>
      _style(isArabic, 16, FontWeight.w400, letterSpacing: 0.3, color: color);

  static TextStyle getBody2TextStyle({required bool isArabic, Color? color}) =>
      _style(isArabic, 14, FontWeight.w400, letterSpacing: 0.25, color: color);

  static TextStyle getButtonTextStyle({required bool isArabic, Color? color}) =>
      _style(isArabic, 14, FontWeight.w600, letterSpacing: 0.5, color: color);

  static TextStyle getCaptionTextStyle({required bool isArabic, Color? color}) =>
      _style(isArabic, 12, FontWeight.w400, letterSpacing: 0.4, color: color);

  static TextStyle getOverLineTextStyle({required bool isArabic, Color? color}) =>
      _style(isArabic, 10, FontWeight.w500, letterSpacing: 1.0, color: color);
}