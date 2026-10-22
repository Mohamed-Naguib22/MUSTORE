import 'package:flutter/material.dart';

abstract final class AppColors {
  static const primary = Color(0xFF1B1F2E);
  static const primaryDark = Color(0xFFF1F3F9);
  static const primaryLight = Color(0xFF3A4160);
  static const secondary = Color(0xFFC8F04A);
  static const secondaryDark = Color(0xFFD4F55E);

  static const lightBackground = Color(0xFFF5F6F8);
  static const lightSurface = Color(0xFFFFFFFF);
  static const lightSurfaceVariant = Color(0xFFECEEF2);
  static const lightOnSurface = Color(0xFF14161F);
  static const lightOnSurfaceVariant = Color(0xFF565B6B);
  static const lightOutline = Color(0xFFCDD0DA);
  static const lightOutlineVariant = Color(0xFFE3E5EB);

  static const lightSurfaceDim = Color(0xFFE6E8EC);
  static const lightSurfaceContainerLow = Color(0xFFFAFBFC);
  static const lightSurfaceContainer = Color(0xFFF3F4F7);
  static const lightSurfaceContainerHigh = Color(0xFFEEF0F3);

  static const lightPrimaryContainer = Color(0xFFE8EAF0);
  static const lightOnPrimaryContainer = Color(0xFF1B1F2E);
  static const lightSecondaryContainer = Color(0xFFF0FBCF);
  static const lightOnSecondaryContainer = Color(0xFF2D3D00);
  static const lightTertiaryContainer = Color(0xFFDDF5EA);
  static const lightOnTertiaryContainer = Color(0xFF0A4630);
  static const lightErrorContainer = Color(0xFFFDE6E7);
  static const lightOnErrorContainer = Color(0xFF5E0F13);

  static const darkBackground = Color(0xFF0D0F14);
  static const darkSurface = Color(0xFF15181F);
  static const darkSurfaceVariant = Color(0xFF20242E);
  static const darkOnSurface = Color(0xFFECEEF3);
  static const darkOnSurfaceVariant = Color(0xFF9EA3B0);
  static const darkOutline = Color(0xFF363B48);
  static const darkOutlineVariant = Color(0xFF272B36);

  static const darkSurfaceBright = Color(0xFF2A2F3B);
  static const darkSurfaceContainerLowest = Color(0xFF0D0F14);
  static const darkSurfaceContainerLow = Color(0xFF12141A);
  static const darkSurfaceContainer = Color(0xFF181B22);
  static const darkSurfaceContainerHigh = Color(0xFF1D2129);

  static const darkPrimaryContainer = Color(0xFF2A2E42);
  static const darkOnPrimaryContainer = Color(0xFFECEEF7);
  static const darkSecondaryContainer = Color(0xFF3A4A0A);
  static const darkOnSecondaryContainer = Color(0xFFD9F78A);
  static const darkTertiaryContainer = Color(0xFF12483A);
  static const darkOnTertiaryContainer = Color(0xFFC5F2E0);
  static const darkErrorContainer = Color(0xFF5E1F22);
  static const darkOnErrorContainer = Color(0xFFFFD9DA);

  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF000000);
  static const transparent = Color(0x00000000);

  static const darkOnAccent = Color(0xFF0D0F14);
  static const onSecondary = Color(0xFF1B1F2E);

  static const bannerIndigo = Color(0xFF3340B5);
  static const bannerIndigoLight = Color(0xFF4A57D1);
  static const bannerEmber = Color(0xFFB8360A);
  static const bannerEmberLight = Color(0xFFD4501E);
  static const bannerForest = Color(0xFF0D6338);
  static const bannerForestLight = Color(0xFF178A52);

  static const onBanner = white;
  static const onBannerMuted = Color(0xD9FFFFFF);
  static const bannerIcon = Color(0x3DFFFFFF);
  static const onBannerSecondary = onSecondary;

  static const List<Color> bannerPrimary = [bannerIndigo, bannerIndigoLight];
  static const List<Color> bannerSecondary = [bannerEmber, bannerEmberLight];
  static const List<Color> bannerSuccess = [bannerForest, bannerForestLight];

  static const success = Color(0xFF117A53);
  static const successBright = Color(0xFF1FA971);
  static const successDark = Color(0xFF4CC9A0);
  static const warning = Color(0xFFF59E0B);
  static const error = Color(0xFFD93A40);
  static const errorDark = Color(0xFFFF6B70);
  static const info = Color(0xFF2E90FA);

  static const rating = Color(0xFFFFB400);
  static const discount = Color(0xFFD1343B);
  static const favorite = Color(0xFFFF4D6D);
  static const priceOld = Color(0xFF8A8FA0);
}