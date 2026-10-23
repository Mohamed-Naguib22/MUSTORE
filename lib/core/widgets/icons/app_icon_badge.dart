import 'package:flutter/material.dart';
import 'package:mustore/core/style/dimens/dimens.dart';

class AppIconBadge extends StatelessWidget {
  const AppIconBadge({
    super.key,
    required this.icon,
    this.isDestructive = false,
    this.isHighlighted = false,
    this.showBackground = true,
    this.size = Dimens.badge,
    this.iconSize = Dimens.iconBadge,
    this.borderRadius = Dimens.borderMd,
  });

  final IconData icon;
  final bool isDestructive;
  final bool isHighlighted;
  final bool showBackground;
  final double size;
  final double iconSize;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    if (!showBackground) {
      final color = isDestructive
          ? scheme.error
          : isHighlighted
          ? scheme.primary
          : scheme.onSurfaceVariant;

      return SizedBox(
        width: size,
        height: size,
        child: Icon(icon, size: iconSize, color: color),
      );
    }

    final (bg, fg) = switch ((isDestructive, isHighlighted)) {
      (true, _) => (
      scheme.errorContainer.withValues(alpha: 0.6),
      scheme.onErrorContainer,
      ),
      (_, true) => (scheme.primary, scheme.onPrimary),
      _ => (scheme.surfaceContainerHighest, scheme.onPrimaryContainer),
    };

    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: borderRadius,
      ),
      child: Icon(icon, size: iconSize, color: fg),
    );
  }
}