// core/widgets/lists/app_list_tile.dart
import 'package:flutter/material.dart';
import 'package:mustore/core/style/colors/app_colors.dart';
import 'package:mustore/core/style/dimens/dimens.dart';

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

  /// Shortcut: rendered inside a tinted rounded badge.
  final IconData? icon;

  /// Fully custom leading widget (e.g. an avatar). Overrides [icon].
  final Widget? leading;

  /// Overrides the default chevron.
  final Widget? trailing;

  final VoidCallback? onTap;

  /// Uses the error colors (delete account, log out, ...).
  final bool isDestructive;

  /// Shows a chevron when [onTap] is set and no [trailing] is given.
  final bool showChevron;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final text = theme.textTheme;

    final titleColor = isDestructive ? scheme.error : scheme.onSurface;

    final leadingWidget = leading ??
        (icon != null
            ? _IconBadge(icon: icon!, isDestructive: isDestructive)
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
            // Every row gets the same height, with or without subtitle or switch.
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

class _IconBadge extends StatelessWidget {
  const _IconBadge({required this.icon, required this.isDestructive});

  final IconData icon;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      width: Dimens.badge,
      height: Dimens.badge,
      decoration: BoxDecoration(
        color: isDestructive ? scheme.errorContainer : scheme.primaryContainer,
        borderRadius: Dimens.borderMd,
      ),
      child: Icon(
        icon,
        size: Dimens.iconBadge,
        color: isDestructive
            ? scheme.onErrorContainer
            : scheme.onPrimaryContainer,
      ),
    );
  }
}