import 'package:flutter/widgets.dart';

abstract final class Dimens {
  static const double xxs = 2;
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double xxl = 32;
  static const double xxxl = 48;

  static const SizedBox gapXxs = SizedBox(width: xxs, height: xxs);
  static const SizedBox gapXs = SizedBox(width: xs, height: xs);
  static const SizedBox gapSm = SizedBox(width: sm, height: sm);
  static const SizedBox gapMd = SizedBox(width: md, height: md);
  static const SizedBox gapLg = SizedBox(width: lg, height: lg);
  static const SizedBox gapXl = SizedBox(width: xl, height: xl);
  static const SizedBox gapXxl = SizedBox(width: xxl, height: xxl);

  static const EdgeInsetsDirectional screenH = EdgeInsetsDirectional.symmetric(horizontal: lg);

  static const EdgeInsetsDirectional screen = EdgeInsetsDirectional.all(lg);

  static const EdgeInsetsDirectional section =  EdgeInsetsDirectional.fromSTEB(lg, xl, sm, sm);

  static const EdgeInsetsDirectional cardPadding = EdgeInsetsDirectional.all(md);
  static const EdgeInsetsDirectional listTile = EdgeInsetsDirectional.symmetric(horizontal: lg, vertical: sm);

  static const double radiusXs = 4;
  static const double radiusSm = 8;
  static const double radiusMd = 12;
  static const double radiusLg = 16;
  static const double radiusXl = 20;
  static const double radiusPill = 999;

  static const BorderRadius borderSm = BorderRadius.all(Radius.circular(radiusSm));
  static const BorderRadius borderMd = BorderRadius.all(Radius.circular(radiusMd));
  static const BorderRadius borderLg = BorderRadius.all(Radius.circular(radiusLg));
  static const BorderRadius borderXl = BorderRadius.all(Radius.circular(radiusXl));
  static const BorderRadius borderPill = BorderRadius.all(Radius.circular(radiusPill));

  static const double iconSm = 16;
  static const double iconMd = 24;
  static const double iconLg = 40;
  static const double iconXl = 72;

  static const double badge = 36;
  static const double iconBadge = 18;

  static const double appBarHeight = 52;

  static const double illustration = 220;

  static const double buttonHeight = 48;
  static const double buttonHeightSm = 44;

  static const double fontSm = 13;

  static const double listTileInset = lg + badge + md;

  static const Duration fast = Duration(milliseconds: 150);
  static const Duration normal = Duration(milliseconds: 250);
  static const Duration slow = Duration(milliseconds: 400);
}