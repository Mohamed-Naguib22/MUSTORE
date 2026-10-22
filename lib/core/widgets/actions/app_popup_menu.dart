import 'package:flutter/material.dart';
import 'package:mustore/core/style/colors/app_colors.dart';
import 'package:mustore/core/style/dimens/dimens.dart';
import 'package:mustore/core/widgets/buttons/app_icon_button.dart';

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
    this.width = 190,
    this.borderRadius = Dimens.borderMd,
  });

  final List<AppPopupMenuItem<T>> items;
  final ValueChanged<T> onSelected;
  final IconData icon;
  final String? tooltip;
  final bool enabled;
  final Widget Function(BuildContext context, VoidCallback open)? builder;

  final double width;
  final BorderRadius borderRadius;

  Future<void> _open(BuildContext triggerContext) async {
    final button = triggerContext.findRenderObject()! as RenderBox;
    final overlay =
    Navigator.of(triggerContext).overlay!.context.findRenderObject()!
    as RenderBox;

    final rect =
    button.localToGlobal(Offset.zero, ancestor: overlay) & button.size;
    final isRtl = Directionality.of(triggerContext) == TextDirection.rtl;
    final s = Theme.of(triggerContext).colorScheme;

    final left = isRtl ? rect.left : rect.right - width;
    final top = rect.bottom + Dimens.xs;

    final position = RelativeRect.fromLTRB(
      left,
      top,
      overlay.size.width - (left + width),
      overlay.size.height - top,
    );

    final value = await showMenu<T>(
      context: triggerContext,
      position: position,
      color: s.surface,
      elevation: 0,
      shadowColor: AppColors.transparent,
      surfaceTintColor: AppColors.transparent,
      constraints: BoxConstraints.tightFor(width: width),
      menuPadding: const EdgeInsets.all(Dimens.xs),
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius,
        side: BorderSide(color: s.outlineVariant),
      ),
      items: [
        for (final item in items) ...[
          if (item.dividerBefore) const PopupMenuDivider(height: Dimens.sm + 1),
          _MenuEntry<T>(item: item, radius: borderRadius),
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
  const _MenuEntry({required this.item, required this.radius});

  final AppPopupMenuItem<T> item;
  final BorderRadius radius;

  static const double _height = 44;

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
    final textColor = disabled
        ? s.onSurface.withValues(alpha: 0.38)
        : (item.isDestructive ? s.error : s.onSurface);
    final iconColor = disabled
        ? s.onSurface.withValues(alpha: 0.38)
        : (item.isDestructive ? s.error : s.onSurfaceVariant);
    final accent = item.isDestructive ? s.error : s.primary;

    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: disabled ? null : () => Navigator.pop<T>(context, item.value),
        borderRadius: widget.radius,
        splashColor: accent.withValues(alpha: 0.12),
        highlightColor: AppColors.transparent,
        hoverColor: accent.withValues(alpha: 0.06),
        child: SizedBox(
          height: _MenuEntry._height,
          child: Padding(
            padding: const EdgeInsetsDirectional.symmetric(
              horizontal: Dimens.md,
            ),
            child: Row(
              children: [
                if (item.icon != null) ...[
                  Icon(
                    item.icon,
                    size: Dimens.iconMd - Dimens.xs,
                    color: iconColor,
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