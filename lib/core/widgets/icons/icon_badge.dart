import 'package:flutter/material.dart';
import 'package:mustore/core/style/dimens/dimens.dart';

class IconBadge extends StatelessWidget {
  const IconBadge({
    super.key,
    required this.icon,
    this.isDestructive = false,
    this.isHighlighted = false,
    this.size = Dimens.badge,
    this.iconSize = Dimens.iconBadge,
    this.borderRadius = Dimens.borderMd,
  });

  final IconData icon;
  final bool isDestructive;
  final bool isHighlighted;
  final double size;
  final double iconSize;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    final (bg, fg) = switch ((isDestructive, isHighlighted)) {
      (true, _) => (
      scheme.errorContainer.withValues(alpha: 0.6),
      scheme.onErrorContainer,
      ),
      (_, true) => (scheme.primaryContainer, scheme.onPrimaryContainer),
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