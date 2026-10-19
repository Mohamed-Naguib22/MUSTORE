import 'package:flutter/material.dart';

abstract final class AppColors {
  static const primary = Color(0xFF3B5BFE);
  static const primaryDark = Color(0xFF8FA3FF);
  static const secondary = Color(0xFFFF7A1A);
  static const secondaryDark = Color(0xFFFF9A4D);

  static const lightBackground = Color(0xFFF7F8FC);
  static const lightSurface = Color(0xFFFFFFFF);
  static const lightSurfaceVariant = Color(0xFFEEF0F7);
  static const lightOnSurface = Color(0xFF14172A);
  static const lightOnSurfaceVariant = Color(0xFF5B6078);
  static const lightOutline = Color(0xFFD9DCE8);
  static const lightOutlineVariant = Color(0xFFE8EAF2);

  static const lightSurfaceDim = Color(0xFFE6E8F0);
  static const lightSurfaceContainerLow = Color(0xFFFAFBFE);
  static const lightSurfaceContainer = Color(0xFFF4F5FB);
  static const lightSurfaceContainerHigh = Color(0xFFF0F2F8);

  static const lightPrimaryContainer = Color(0xFFE4E9FF);
  static const lightOnPrimaryContainer = Color(0xFF0F1E7A);
  static const lightSecondaryContainer = Color(0xFFFFE8D4);
  static const lightOnSecondaryContainer = Color(0xFF5A2700);
  static const lightTertiaryContainer = Color(0xFFDDF5EA);
  static const lightOnTertiaryContainer = Color(0xFF0A4630);
  static const lightErrorContainer = Color(0xFFFDE6E7);
  static const lightOnErrorContainer = Color(0xFF5E0F13);

  static const darkBackground = Color(0xFF0E1018);
  static const darkSurface = Color(0xFF171A25);
  static const darkSurfaceVariant = Color(0xFF222636);
  static const darkOnSurface = Color(0xFFECEEF7);
  static const darkOnSurfaceVariant = Color(0xFF9BA1B8);
  static const darkOutline = Color(0xFF343950);
  static const darkOutlineVariant = Color(0xFF2A2E42);

  static const darkSurfaceBright = Color(0xFF2A2F42);
  static const darkSurfaceContainerLowest = Color(0xFF0E1018);
  static const darkSurfaceContainerLow = Color(0xFF141722);
  static const darkSurfaceContainer = Color(0xFF1A1D29);
  static const darkSurfaceContainerHigh = Color(0xFF1E2230);

  static const darkPrimaryContainer = Color(0xFF2A3880);
  static const darkOnPrimaryContainer = Color(0xFFDDE3FF);
  static const darkSecondaryContainer = Color(0xFF5A3014);
  static const darkOnSecondaryContainer = Color(0xFFFFDCC2);
  static const darkTertiaryContainer = Color(0xFF12483A);
  static const darkOnTertiaryContainer = Color(0xFFC5F2E0);
  static const darkErrorContainer = Color(0xFF5E1F22);
  static const darkOnErrorContainer = Color(0xFFFFD9DA);

  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF000000);
  static const transparent = Color(0x00000000);

  static const darkOnAccent = Color(0xFF0E1018);

  static const onSecondary = Color(0xFF14172A);

  static const primaryLight = Color(0xFF6C86FF);

  static const onBanner = white;
  static const onBannerMuted = Color(0xB3FFFFFF);
  static const bannerIcon = Color(0x3DFFFFFF);

  static const onBannerSecondary = onSecondary;

  static const List<Color> bannerPrimary = [primary, primaryLight];
  static const List<Color> bannerSecondary = [secondary, secondaryDark];
  static const List<Color> bannerSuccess = [success, successBright];

  static const success = Color(0xFF117A53);
  static const successBright = Color(0xFF1FA971);
  static const successDark = Color(0xFF4CC9A0);
  static const warning = Color(0xFFF5B301);
  static const error = Color(0xFFE5484D);
  static const errorDark = Color(0xFFFF6B70);
  static const rating = Color(0xFFFFB400);
}