import 'package:flutter/material.dart';
import 'package:mustore/core/style/colors/app_colors.dart';
import 'package:mustore/core/style/dimens/dimens.dart';
import 'package:mustore/core/widgets/buttons/app_button.dart';
import 'package:mustore/core/widgets/cards/app_card.dart';
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

  static const double _iconBadge = Dimens.iconXl + Dimens.xl;
  static const double _buttonHeight = Dimens.xxl + Dimens.xs;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final l10n = S.of(context);

    return AppCard(
      variant: AppCardVariant.filled,
      color: banner.colors.first,
      padding: const EdgeInsetsDirectional.all(Dimens.xl),
      child: Row(
        children: [
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: AlignmentDirectional.centerStart,
                  child: SizedBox(
                    width: constraints.maxWidth,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          banner.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: text.titleLarge?.copyWith(
                            color: AppColors.onBanner,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Dimens.gapXs,
                        Text(
                          banner.subtitle,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: text.bodyMedium?.copyWith(
                            color: AppColors.onBannerMuted,
                          ),
                        ),
                        Dimens.gapLg,
                        AppButton(
                          label: l10n.homeShopNow,
                          expand: false,
                          height: _buttonHeight,
                          backgroundColor: AppColors.onBanner,
                          foregroundColor: banner.colors.first,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Dimens.gapMd,
          Container(
            width: _iconBadge,
            height: _iconBadge,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.onBanner.withValues(alpha: 0.16),
            ),
            child: Icon(
              banner.icon,
              size: Dimens.iconLg,
              color: AppColors.onBanner,
            ),
          ),
        ],
      ),
    );
  }
}