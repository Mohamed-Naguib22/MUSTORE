import 'package:flutter/material.dart';
import 'package:mustore/core/style/dimens/dimens.dart';
import 'package:mustore/core/utils/constants/app_assets.dart';
import 'package:mustore/core/widgets/media/app_asset.dart';

class LanguageFlagBadgeWidget extends StatelessWidget {
  const LanguageFlagBadgeWidget({super.key, required this.isArabic});

  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      width: Dimens.iconLg,
      height: Dimens.iconLg,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: Dimens.borderMd,
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: ClipRRect(
        borderRadius: Dimens.borderSm,
        child: SizedBox(
          width: Dimens.xxl,
          height: Dimens.xl,
          child: AppAsset(
            isArabic ? AppAssets.flagEg : AppAssets.flagEn,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}