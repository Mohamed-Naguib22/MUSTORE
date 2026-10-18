import 'package:flutter/material.dart';
import 'package:mustore/core/style/colors/app_colors.dart';
import 'package:mustore/core/style/fonts/font_provider.dart';

abstract final class AppTheme {
  static ThemeData light({required bool isArabic}) => _build(
    isArabic: isArabic,
    background: AppColors.lightBackground,
    scheme: const ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primary,
      onPrimary: Colors.white,
      secondary: AppColors.secondary,
      onSecondary: Colors.white,
      error: AppColors.error,
      onError: Colors.white,
      surface: AppColors.lightSurface,
      onSurface: AppColors.lightOnSurface,
      surfaceContainerHighest: AppColors.lightSurfaceVariant,
      onSurfaceVariant: AppColors.lightOnSurfaceVariant,
      outline: AppColors.lightOutline,
    ),
  );

  static ThemeData dark({required bool isArabic}) => _build(
    isArabic: isArabic,
    background: AppColors.darkBackground,
    scheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.primaryDark,
      onPrimary: Color(0xFF0E1018),
      secondary: AppColors.secondaryDark,
      onSecondary: Color(0xFF0E1018),
      error: AppColors.errorDark,
      onError: Color(0xFF0E1018),
      surface: AppColors.darkSurface,
      onSurface: AppColors.darkOnSurface,
      surfaceContainerHighest: AppColors.darkSurfaceVariant,
      onSurfaceVariant: AppColors.darkOnSurfaceVariant,
      outline: AppColors.darkOutline,
    ),
  );

  static ThemeData _build({
    required bool isArabic,
    required Color background,
    required ColorScheme scheme,
  }) {
    final c = scheme.onSurface;
    final a = isArabic;

    final textTheme = TextTheme(
      displayLarge: FontsProvider.getHeadline1TextStyle(isArabic: a, color: c),
      displayMedium: FontsProvider.getHeadline2TextStyle(isArabic: a, color: c),
      displaySmall: FontsProvider.getHeadline3TextStyle(isArabic: a, color: c),
      headlineLarge: FontsProvider.getHeadline4TextStyle(isArabic: a, color: c),
      headlineMedium: FontsProvider.getHeadline4TextStyle(isArabic: a, color: c),
      headlineSmall: FontsProvider.getHeadline5TextStyle(isArabic: a, color: c),
      titleLarge: FontsProvider.getHeadline6TextStyle(isArabic: a, color: c),
      titleMedium: FontsProvider.getSubtitle1TextStyle(isArabic: a, color: c),
      titleSmall: FontsProvider.getSubtitle2TextStyle(isArabic: a, color: c),
      bodyLarge: FontsProvider.getBody1TextStyle(isArabic: a, color: c),
      bodyMedium: FontsProvider.getBody2TextStyle(isArabic: a, color: c),
      bodySmall: FontsProvider.getCaptionTextStyle(isArabic: a, color: c),
      labelLarge: FontsProvider.getButtonTextStyle(isArabic: a, color: c),
      labelMedium: FontsProvider.getCaptionTextStyle(isArabic: a, color: c),
      labelSmall: FontsProvider.getOverLineTextStyle(isArabic: a, color: c),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: scheme.brightness,
      scaffoldBackgroundColor: background,
      colorScheme: scheme,
      textTheme: textTheme,
      appBarTheme: AppBarTheme(titleTextStyle: textTheme.titleLarge),
      navigationBarTheme: NavigationBarThemeData(
        labelTextStyle: WidgetStatePropertyAll(textTheme.labelMedium),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(textStyle: textTheme.labelLarge),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(textStyle: textTheme.labelLarge),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(textStyle: textTheme.labelLarge),
      ),
    );
  }
}