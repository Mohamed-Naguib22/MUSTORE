import 'package:flutter/material.dart';
import 'package:mustore/core/style/colors/app_colors.dart';
import 'package:mustore/core/style/dimens/dimens.dart';
import 'package:mustore/core/widgets/buttons/app_button.dart';
import 'package:mustore/generated/l10n.dart';

class HomeBanner {
  const HomeBanner({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.colors,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final List<Color> colors;
}


class BannerCardWidget extends StatelessWidget {
  const BannerCardWidget({super.key, required this.banner});

  final HomeBanner banner;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final l10n = S.of(context);

    return Container(
      padding: const EdgeInsetsDirectional.all(Dimens.lg + Dimens.xs),
      decoration: BoxDecoration(
        borderRadius: Dimens.borderXl,
        gradient: LinearGradient(
          begin: AlignmentDirectional.topStart,
          end: AlignmentDirectional.bottomEnd,
          colors: banner.colors,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  banner.title,
                  style: text.titleLarge?.copyWith(
                    color: AppColors.onBanner,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Dimens.gapXs,
                Text(
                  banner.subtitle,
                  style: text.bodyMedium?.copyWith(color: AppColors.onBannerMuted),
                ),
                Dimens.gapMd,
                AppButton(
                  label: l10n.homeShopNow,
                  expand: false,
                  height: 36,
                  backgroundColor: AppColors.onBanner,
                  foregroundColor: banner.colors.first,
                  onPressed: () {},
                ),
              ],
            ),
          ),
          Icon(banner.icon, size: Dimens.iconXl, color: AppColors.bannerIcon),
        ],
      ),
    );
  }
}