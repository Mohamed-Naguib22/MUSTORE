import 'package:flutter/material.dart';
import 'package:mustore/core/style/dimens/dimens.dart';

class IconBadge extends StatelessWidget {
  const IconBadge({
    super.key,
    required this.icon,
    this.isDestructive = false,
    this.isHighlighted = false,
  });

  final IconData icon;
  final bool isDestructive;
  final bool isHighlighted;

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
      width: Dimens.badge,
      height: Dimens.badge,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: Dimens.borderMd,
      ),
      child: Icon(icon, size: Dimens.iconBadge, color: fg),
    );
  }
}