import 'package:flutter/material.dart';
import 'package:mustore/core/style/colors/app_colors.dart';
import 'package:mustore/core/style/dimens/dimens.dart';

enum AppIconButtonVariant {
  primary,
  tonal,
  plain,
  danger,
}

class AppIconButton extends StatelessWidget {
  const AppIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.tooltip,
    this.variant = AppIconButtonVariant.tonal,
    this.size = Dimens.badge,
    this.iconSize = Dimens.iconBadge,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final String? tooltip;
  final AppIconButtonVariant variant;
  final double size;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final s = Theme.of(context).colorScheme;
    final enabled = onPressed != null;

    final (bg, fg) = switch (variant) {
      AppIconButtonVariant.primary => (s.primary, s.onPrimary),
      AppIconButtonVariant.tonal => (
      s.surfaceContainerHighest,
      s.onSurface,
      ),
      AppIconButtonVariant.plain => (AppColors.transparent, s.onSurfaceVariant),
      AppIconButtonVariant.danger => (s.errorContainer, s.onErrorContainer),
    };

    final button = Material(
      color: enabled ? bg : s.onSurface.withValues(alpha: 0.12),
      borderRadius: Dimens.borderMd,
      child: InkWell(
        onTap: onPressed,
        borderRadius: Dimens.borderMd,
        splashColor: fg.withValues(alpha: 0.12),
        highlightColor: AppColors.transparent,
        child: SizedBox(
          width: size,
          height: size,
          child: Icon(
            icon,
            size: iconSize,
            color: enabled ? fg : s.onSurface.withValues(alpha: 0.38),
          ),
        ),
      ),
    );

    return tooltip == null ? button : Tooltip(message: tooltip!, child: button);
  }
}