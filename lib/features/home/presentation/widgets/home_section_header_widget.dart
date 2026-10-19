import 'package:flutter/material.dart';
import 'package:mustore/core/style/dimens/dimens.dart';
import 'package:mustore/core/widgets/buttons/app_text_button.dart';
import 'package:mustore/generated/l10n.dart';

class HomeSectionHeaderWidget extends StatelessWidget {
  const HomeSectionHeaderWidget({
    super.key,
    required this.title,
    this.onSeeAll,
  });

  final String title;
  final VoidCallback? onSeeAll;

  static const EdgeInsetsDirectional _padding = EdgeInsetsDirectional.fromSTEB(
    Dimens.lg,
    Dimens.xl,
    Dimens.lg - Dimens.xs,
    Dimens.sm,
  );

  static const EdgeInsetsDirectional _seeAllPadding =
  EdgeInsetsDirectional.only(
    start: Dimens.sm,
    end: Dimens.xs,
    top: Dimens.xs,
    bottom: Dimens.xs,
  );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Padding(
      padding: _padding,
      child: Row(
        children: [
          Container(
            width: Dimens.xs,
            height: Dimens.lg,
            decoration: BoxDecoration(
              color: scheme.primary,
              borderRadius: Dimens.borderPill,
            ),
          ),
          Dimens.gapSm,
          Expanded(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.titleMedium?.copyWith(
                color: scheme.onSurface,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          if (onSeeAll != null)
            AppTextButton(
              label: S.of(context).homeSeeAll,
              trailingIcon: Icons.chevron_right_rounded,
              onPressed: onSeeAll,
              compact: true,
              textStyle: theme.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
              iconSize: Dimens.iconSm + Dimens.xs,
              iconGap: Dimens.xxs,
              padding: _seeAllPadding,
              tightText: true,
              iconOffset: 1.5,
            ),
        ],
      ),
    );
  }
}