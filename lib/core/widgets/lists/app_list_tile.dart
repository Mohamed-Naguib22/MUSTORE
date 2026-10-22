import 'package:flutter/material.dart';
import 'package:mustore/core/style/colors/app_colors.dart';
import 'package:mustore/core/style/dimens/dimens.dart';
import 'package:mustore/core/widgets/icons/icon_badge.dart';

class AppListTile extends StatelessWidget {
  const AppListTile({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
    this.leading,
    this.trailing,
    this.onTap,
    this.isDestructive = false,
    this.showChevron = true,
  }) : assert(
  icon == null || leading == null,
  'Provide either icon or leading, not both.',
  );

  final String title;
  final String? subtitle;
  final IconData? icon;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool isDestructive;
  final bool showChevron;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final text = theme.textTheme;

    final titleColor = isDestructive ? scheme.error : scheme.onSurface;

    final leadingWidget = leading ??
        (icon != null
            ? IconBadge(icon: icon!, isDestructive: isDestructive)
            : null);

    final trailingWidget = trailing ??
        (onTap != null && showChevron
            ? Icon(
          Icons.chevron_right_rounded,
          size: Dimens.iconMd - Dimens.xs,
          color: scheme.onSurfaceVariant,
        )
            : null);

    return Material(
      color: AppColors.transparent,
      borderRadius: Dimens.borderMd,
      child: InkWell(
        onTap: onTap,
        borderRadius: Dimens.borderMd,
        child: Padding(
          padding: Dimens.listTile,
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: Dimens.badge),
            child: Row(
              children: [
                if (leadingWidget != null) ...[
                  leadingWidget,
                  Dimens.gapMd,
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: text.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: titleColor,
                        ),
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: Dimens.xxs),
                        Text(
                          subtitle!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: text.bodySmall?.copyWith(
                            color: scheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                if (trailingWidget != null) ...[
                  Dimens.gapSm,
                  trailingWidget,
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
