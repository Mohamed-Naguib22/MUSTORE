import 'package:flutter/material.dart';
import 'package:mustore/core/style/dimens/dimens.dart';

class AppNavItem {
  const AppNavItem({
    required this.icon,
    required this.selectedIcon,
    required this.label,
  });

  final IconData icon;
  final IconData selectedIcon;
  final String label;
}

class AppBottomNavBar extends StatelessWidget {
  const AppBottomNavBar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onSelected,
  });

  final List<AppNavItem> items;
  final int currentIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    final s = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: s.surface,
        border: Border(top: BorderSide(color: s.outlineVariant)),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: Dimens.xxxl + Dimens.lg,
          child: Row(
            children: [
              for (var i = 0; i < items.length; i++)
                Expanded(
                  child: _NavTile(
                    item: items[i],
                    selected: i == currentIndex,
                    onTap: () => onSelected(i),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavTile extends StatelessWidget {
  const _NavTile({
    required this.item,
    required this.selected,
    required this.onTap,
  });

  final AppNavItem item;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final s = theme.colorScheme;
    final color = selected ? s.primary : s.onSurfaceVariant;

    return Semantics(
      button: true,
      selected: selected,
      label: item.label,
      child: InkWell(
        onTap: onTap,
        overlayColor: WidgetStatePropertyAll(
          s.primary.withValues(alpha: 0.06),
        ),
        child: Stack(
          children: [
            Align(
              alignment: AlignmentDirectional.topCenter,
              child: AnimatedContainer(
                duration: Dimens.normal,
                curve: Curves.easeOutCubic,
                width: selected ? Dimens.xxl : 0,
                height: 3,
                decoration: BoxDecoration(
                  color: s.primary,
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(Dimens.radiusXs),
                  ),
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    selected ? item.selectedIcon : item.icon,
                    size: Dimens.iconMd,
                    color: color,
                  ),
                  Dimens.gapXxs,
                  Text(
                    item.label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: color,
                      fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}