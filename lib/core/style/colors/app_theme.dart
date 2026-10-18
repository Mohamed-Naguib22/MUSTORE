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
      onPrimary: AppColors.white,
      primaryContainer: AppColors.lightPrimaryContainer,
      onPrimaryContainer: AppColors.lightOnPrimaryContainer,
      secondary: AppColors.secondary,
      onSecondary: AppColors.white,
      secondaryContainer: AppColors.lightSecondaryContainer,
      onSecondaryContainer: AppColors.lightOnSecondaryContainer,
      tertiary: AppColors.success,
      onTertiary: AppColors.white,
      tertiaryContainer: AppColors.lightTertiaryContainer,
      onTertiaryContainer: AppColors.lightOnTertiaryContainer,
      error: AppColors.error,
      onError: AppColors.white,
      errorContainer: AppColors.lightErrorContainer,
      onErrorContainer: AppColors.lightOnErrorContainer,
      surface: AppColors.lightSurface,
      onSurface: AppColors.lightOnSurface,
      onSurfaceVariant: AppColors.lightOnSurfaceVariant,
      surfaceDim: AppColors.lightSurfaceDim,
      surfaceBright: AppColors.lightSurface,
      surfaceContainerLowest: AppColors.lightSurface,
      surfaceContainerLow: AppColors.lightSurfaceContainerLow,
      surfaceContainer: AppColors.lightSurfaceContainer,
      surfaceContainerHigh: AppColors.lightSurfaceContainerHigh,
      surfaceContainerHighest: AppColors.lightSurfaceVariant,
      outline: AppColors.lightOutline,
      outlineVariant: AppColors.lightOutlineVariant,
      shadow: AppColors.black,
      scrim: AppColors.black,
      inverseSurface: AppColors.lightOnSurface,
      onInverseSurface: AppColors.lightBackground,
      inversePrimary: AppColors.primaryDark,
      surfaceTint: AppColors.transparent,
    ),
  );

  static ThemeData dark({required bool isArabic}) => _build(
    isArabic: isArabic,
    background: AppColors.darkBackground,
    scheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.primaryDark,
      onPrimary: AppColors.darkOnAccent,
      primaryContainer: AppColors.darkPrimaryContainer,
      onPrimaryContainer: AppColors.darkOnPrimaryContainer,
      secondary: AppColors.secondaryDark,
      onSecondary: AppColors.darkOnAccent,
      secondaryContainer: AppColors.darkSecondaryContainer,
      onSecondaryContainer: AppColors.darkOnSecondaryContainer,
      tertiary: AppColors.successDark,
      onTertiary: AppColors.darkOnAccent,
      tertiaryContainer: AppColors.darkTertiaryContainer,
      onTertiaryContainer: AppColors.darkOnTertiaryContainer,
      error: AppColors.errorDark,
      onError: AppColors.darkOnAccent,
      errorContainer: AppColors.darkErrorContainer,
      onErrorContainer: AppColors.darkOnErrorContainer,
      surface: AppColors.darkSurface,
      onSurface: AppColors.darkOnSurface,
      onSurfaceVariant: AppColors.darkOnSurfaceVariant,
      surfaceDim: AppColors.darkBackground,
      surfaceBright: AppColors.darkSurfaceBright,
      surfaceContainerLowest: AppColors.darkSurfaceContainerLowest,
      surfaceContainerLow: AppColors.darkSurfaceContainerLow,
      surfaceContainer: AppColors.darkSurfaceContainer,
      surfaceContainerHigh: AppColors.darkSurfaceContainerHigh,
      surfaceContainerHighest: AppColors.darkSurfaceVariant,
      outline: AppColors.darkOutline,
      outlineVariant: AppColors.darkOutlineVariant,
      shadow: AppColors.black,
      scrim: AppColors.black,
      inverseSurface: AppColors.darkOnSurface,
      onInverseSurface: AppColors.darkBackground,
      inversePrimary: AppColors.primary,
      surfaceTint: AppColors.transparent,
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
      appBarTheme: AppBarTheme(
        titleTextStyle: textTheme.titleLarge,
        backgroundColor: background,
        surfaceTintColor: AppColors.transparent,
        scrolledUnderElevation: 0,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: scheme.surface,
        surfaceTintColor: AppColors.transparent,
        indicatorColor: scheme.primaryContainer,
        iconTheme: WidgetStateProperty.resolveWith(
              (states) => IconThemeData(
            color: states.contains(WidgetState.selected)
                ? scheme.onPrimaryContainer
                : scheme.onSurfaceVariant,
          ),
        ),
        labelTextStyle: WidgetStateProperty.resolveWith(
              (states) {
            final selected = states.contains(WidgetState.selected);
            return textTheme.labelMedium?.copyWith(
              color: selected ? scheme.onSurface : scheme.onSurfaceVariant,
              fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
            );
          },
        ),
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