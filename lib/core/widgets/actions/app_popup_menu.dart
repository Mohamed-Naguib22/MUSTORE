import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:mustore/core/style/colors/app_colors.dart';
import 'package:mustore/core/style/dimens/dimens.dart';
import 'package:mustore/core/widgets/buttons/app_icon_button.dart';
import 'package:mustore/core/widgets/icons/icon_badge.dart';

class AppPopupMenuItem<T> {
  const AppPopupMenuItem({
    required this.value,
    required this.label,
    this.icon,
    this.isDestructive = false,
    this.enabled = true,
    this.dividerBefore = false,
  });

  final T value;
  final String label;
  final IconData? icon;
  final bool isDestructive;
  final bool enabled;
  final bool dividerBefore;
}

class AppPopupMenu<T> extends StatelessWidget {
  const AppPopupMenu({
    super.key,
    required this.items,
    required this.onSelected,
    this.icon = Icons.more_vert_rounded,
    this.tooltip,
    this.enabled = true,
    this.builder,
    this.width,
    this.maxWidth = 200,
    this.borderRadius = Dimens.borderMd,
  });

  final List<AppPopupMenuItem<T>> items;
  final ValueChanged<T> onSelected;
  final IconData icon;
  final String? tooltip;
  final bool enabled;
  final Widget Function(BuildContext context, VoidCallback open)? builder;
  final double? width;
  final double maxWidth;
  final BorderRadius borderRadius;

  static const double _borderAllowance = 2;
  static const double _extraSpace = Dimens.lg;
  static const double _badgeIconSize = Dimens.iconSm;
  static const double _badgeSize = _badgeIconSize + Dimens.md;

  double _resolveWidth(BuildContext context) {
    if (width != null) return width!;

    final style = Theme.of(context).textTheme.bodyMedium?.copyWith(
      fontWeight: FontWeight.w500,
    );
    final scaler = MediaQuery.textScalerOf(context);
    final direction = Directionality.of(context);

    var widest = 0.0;
    for (final item in items) {
      final painter = TextPainter(
        text: TextSpan(text: item.label, style: style),
        textDirection: direction,
        textScaler: scaler,
        maxLines: 1,
      )..layout();

      final leading = item.icon != null ? _badgeSize + Dimens.md : 0.0;

      widest = math.max(widest, painter.width.ceilToDouble() + leading);
      painter.dispose();
    }

    const chrome = Dimens.sm * 2 + Dimens.xs * 2 + _borderAllowance;
    return math.min(widest + chrome + _extraSpace, maxWidth);
  }

  Future<void> _open(BuildContext triggerContext) async {
    final button = triggerContext.findRenderObject()! as RenderBox;
    final overlay =
    Navigator.of(triggerContext).overlay!.context.findRenderObject()!
    as RenderBox;

    final rect =
    button.localToGlobal(Offset.zero, ancestor: overlay) & button.size;
    final isRtl = Directionality.of(triggerContext) == TextDirection.rtl;
    final s = Theme.of(triggerContext).colorScheme;

    final menuWidth = _resolveWidth(triggerContext);

    final maxLeft = overlay.size.width - menuWidth - Dimens.sm;
    final left = (isRtl ? rect.left : rect.right - menuWidth)
        .clamp(Dimens.sm, maxLeft < Dimens.sm ? Dimens.sm : maxLeft)
        .toDouble();
    final top = rect.bottom + Dimens.xs;

    final position = RelativeRect.fromLTRB(
      left,
      top,
      overlay.size.width - (left + menuWidth),
      overlay.size.height - top,
    );

    final value = await showMenu<T>(
      context: triggerContext,
      position: position,
      color: s.surface,
      elevation: 0,
      shadowColor: AppColors.transparent,
      surfaceTintColor: AppColors.transparent,
      constraints: BoxConstraints.tightFor(width: menuWidth),
      menuPadding: const EdgeInsets.all(Dimens.xs),
      popUpAnimationStyle: AnimationStyle(
        duration: Dimens.fast,
        reverseDuration: Dimens.fast,
        curve: Curves.easeOutCubic,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius,
        side: BorderSide(color: s.outlineVariant),
      ),
      items: [
        for (final item in items) ...[
          if (item.dividerBefore) const PopupMenuDivider(height: Dimens.md),
          _MenuEntry<T>(item: item),
        ],
      ],
    );

    if (value != null) onSelected(value);
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (triggerContext) =>
      builder?.call(triggerContext, () => _open(triggerContext)) ??
          AppIconButton(
            icon: icon,
            tooltip: tooltip,
            variant: AppIconButtonVariant.plain,
            onPressed: enabled ? () => _open(triggerContext) : null,
          ),
    );
  }
}

class _MenuEntry<T> extends PopupMenuEntry<T> {
  const _MenuEntry({required this.item});

  final AppPopupMenuItem<T> item;

  static const double _height = Dimens.xxxl - Dimens.xs;

  @override
  double get height => _height;

  @override
  bool represents(T? value) => value == item.value;

  @override
  State<_MenuEntry<T>> createState() => _MenuEntryState<T>();
}

class _MenuEntryState<T> extends State<_MenuEntry<T>> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final s = theme.colorScheme;
    final item = widget.item;

    final disabled = !item.enabled;
    final destructive = item.isDestructive;

    final textColor = disabled
        ? s.onSurface.withValues(alpha: 0.38)
        : (destructive ? s.error : s.onSurface);
    final accent = destructive ? s.error : s.primary;

    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: disabled ? null : () => Navigator.pop<T>(context, item.value),
        borderRadius: Dimens.borderSm,
        splashColor: accent.withValues(alpha: 0.12),
        highlightColor: AppColors.transparent,
        hoverColor: accent.withValues(alpha: 0.06),
        child: SizedBox(
          height: _MenuEntry._height,
          child: Padding(
            padding: const EdgeInsetsDirectional.symmetric(
              horizontal: Dimens.sm,
            ),
            child: Row(
              children: [
                if (item.icon != null) ...[
                  Opacity(
                    opacity: disabled ? 0.38 : 1,
                    child: IconBadge(
                      icon: item.icon!,
                      isDestructive: destructive,
                      size: AppPopupMenu._badgeSize,
                      iconSize: AppPopupMenu._badgeIconSize,
                      borderRadius: Dimens.borderSm,
                    ),
                  ),
                  Dimens.gapMd,
                ],
                Expanded(
                  child: Text(
                    item.label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: textColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}