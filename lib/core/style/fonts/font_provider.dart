import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FontsProvider {
  FontsProvider._();

  static const _arabicHeightBoost = 0.1;

  static TextStyle _style(
      bool isArabic,
      double size,
      FontWeight weight, {
        double letterSpacing = 0,
        double height = 1.35,
        Color? color,
      }) =>
      GoogleFonts.ibmPlexSansArabic(
        fontSize: size,
        fontWeight: weight,
        letterSpacing: isArabic ? 0 : letterSpacing,
        height: isArabic ? height + _arabicHeightBoost : height,
        color: color,
      );

  static TextStyle getHeadline1TextStyle({required bool isArabic, Color? color}) =>
      _style(isArabic, 40, FontWeight.w700, letterSpacing: -0.8, height: 1.15, color: color);

  static TextStyle getHeadline2TextStyle({required bool isArabic, Color? color}) =>
      _style(isArabic, 36, FontWeight.w700, letterSpacing: -0.6, height: 1.15, color: color);

  static TextStyle getHeadline3TextStyle({required bool isArabic, Color? color}) =>
      _style(isArabic, 32, FontWeight.w700, letterSpacing: -0.4, height: 1.2, color: color);

  static TextStyle getHeadline4TextStyle({required bool isArabic, Color? color}) =>
      _style(isArabic, 28, FontWeight.w700, letterSpacing: -0.2, height: 1.2, color: color);

  static TextStyle getHeadline5TextStyle({required bool isArabic, Color? color}) =>
      _style(isArabic, 24, FontWeight.w700, height: 1.25, color: color);

  static TextStyle getHeadline6TextStyle({required bool isArabic, Color? color}) =>
      _style(isArabic, 20, FontWeight.w600, height: 1.3, color: color);

  static TextStyle getSubtitle1TextStyle({required bool isArabic, Color? color}) =>
      _style(isArabic, 16, FontWeight.w600, letterSpacing: 0.1, height: 1.35, color: color);

  static TextStyle getSubtitle2TextStyle({required bool isArabic, Color? color}) =>
      _style(isArabic, 14, FontWeight.w600, letterSpacing: 0.1, height: 1.35, color: color);

  static TextStyle getBody1TextStyle({required bool isArabic, Color? color}) =>
      _style(isArabic, 16, FontWeight.w400, height: 1.45, color: color);

  static TextStyle getBody2TextStyle({required bool isArabic, Color? color}) =>
      _style(isArabic, 14, FontWeight.w400, height: 1.45, color: color);

  static TextStyle getButtonTextStyle({required bool isArabic, Color? color}) =>
      _style(isArabic, 14, FontWeight.w600, letterSpacing: 0.2, height: 1.2, color: color);

  static TextStyle getCaptionTextStyle({required bool isArabic, Color? color}) =>
      _style(isArabic, 12, FontWeight.w500, letterSpacing: 0.2, height: 1.35, color: color);

  static TextStyle getOverLineTextStyle({required bool isArabic, Color? color}) =>
      _style(isArabic, 10, FontWeight.w600, letterSpacing: 0.8, height: 1.3, color: color);

  static TextStyle getPriceTextStyle({
    required bool isArabic,
    Color? color,
    double size = 16,
    FontWeight weight = FontWeight.w700,
  }) =>
      _style(isArabic, size, weight, height: 1.2, color: color)
          .copyWith(fontFeatures: const [FontFeature.tabularFigures()]);
}