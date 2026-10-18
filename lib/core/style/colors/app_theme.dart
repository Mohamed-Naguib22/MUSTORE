import 'package:flutter/material.dart';
import 'package:mustore/core/style/colors/app_colors.dart';

abstract final class AppTheme {
  static final light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.lightBackground,
    colorScheme: const ColorScheme(
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

  static final dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.darkBackground,
    colorScheme: const ColorScheme(
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
}