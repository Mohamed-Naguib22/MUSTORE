import 'package:flutter/material.dart';
import 'package:mustore/core/style/dimens/dimens.dart';
import 'package:mustore/core/style/colors/app_colors.dart';

enum AppTextButtonVariant { primary, secondary, danger, neutral }

class AppTextButton extends StatefulWidget {
  const AppTextButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.trailingIcon,
    this.variant = AppTextButtonVariant.primary,
    this.isLoading = false,
    this.isEnabled,
    this.foregroundColor,
    this.expand = false,
    this.compact = false,
    this.height = Dimens.buttonHeight,
    this.borderRadius = Dimens.borderMd,
    this.textStyle,
    this.iconSize,
    this.iconGap,
    this.padding,
    this.tonal = false,
    this.tightText = false,
    this.iconOffset = 0,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final IconData? trailingIcon;
  final AppTextButtonVariant variant;
  final bool isLoading;
  final ValueNotifier<bool>? isEnabled;
  final Color? foregroundColor;
  final bool expand;
  final bool compact;
  final double height;
  final BorderRadius borderRadius;
  final TextStyle? textStyle;
  final double? iconSize;
  final double? iconGap;
  final EdgeInsetsGeometry? padding;
  final bool tonal;
  final bool tightText;
  final double iconOffset;

  @override
  State<AppTextButton> createState() => _AppTextButtonState();
}

class _AppTextButtonState extends State<AppTextButton> {
  final ValueNotifier<bool> _pressed = ValueNotifier<bool>(false);
  final ValueNotifier<bool> _hovered = ValueNotifier<bool>(false);

  late final Listenable _interaction = Listenable.merge([_pressed, _hovered]);

  @override
  void dispose() {
    _pressed.dispose();
    _hovered.dispose();
    super.dispose();
  }

  Color _foreground(ColorScheme s, bool interactive) {
    if (!interactive) return s.onSurface.withValues(alpha: 0.38);
    if (widget.foregroundColor != null) return widget.foregroundColor!;
    return switch (widget.variant) {
      AppTextButtonVariant.primary => s.primary,
      AppTextButtonVariant.secondary =>
      s.brightness == Brightness.dark ? s.secondary : s.onSecondaryContainer,
      AppTextButtonVariant.danger => s.error,
      AppTextButtonVariant.neutral => s.onSurface,
    };
  }

  Widget _icon(IconData data, double size, Color color) {
    final icon = Icon(data, size: size, color: color);
    if (widget.iconOffset == 0) return icon;

    return Transform.translate(offset: Offset(0, widget.iconOffset), child: icon);
  }

  @override
  Widget build(BuildContext context) {
    final notifier = widget.isEnabled;
    if (notifier == null) return _buildButton(context, true);
    return ValueListenableBuilder<bool>(
      valueListenable: notifier,
      builder: (context, value, _) => _buildButton(context, value),
    );
  }

  Widget _buildButton(BuildContext context, bool externallyEnabled) {
    final interactive = widget.onPressed != null && externallyEnabled;
    final enabled = interactive && !widget.isLoading;

    final theme = Theme.of(context);
    final fg = _foreground(theme.colorScheme, interactive);
    final textStyle = (theme.textTheme.labelMedium?.copyWith(
      fontWeight: FontWeight.bold,
    ) ??
        const TextStyle())
        .merge(widget.textStyle)
        .copyWith(color: fg);
    final iconSize = widget.iconSize ?? Dimens.iconMd - Dimens.xs;
    final gap = SizedBox(width: widget.iconGap ?? Dimens.sm);

    final restingTint = widget.tonal && enabled
        ? fg.withValues(alpha: 0.10)
        : AppColors.transparent;

    final content = Row(
      mainAxisSize: widget.expand ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (widget.icon != null) ...[
          _icon(widget.icon!, iconSize, fg),
          gap,
        ],
        Flexible(
          child: Text(
            widget.label,
            style: textStyle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textHeightBehavior: widget.tightText
                ? const TextHeightBehavior(
              applyHeightToFirstAscent: false,
              applyHeightToLastDescent: false,
              leadingDistribution: TextLeadingDistribution.even,
            )
                : null,
          ),
        ),
        if (widget.trailingIcon != null) ...[
          gap,
          _icon(widget.trailingIcon!, iconSize, fg),
        ],
      ],
    );

    final body = Stack(
      alignment: Alignment.center,
      children: [
        AnimatedOpacity(
          duration: Dimens.fast,
          opacity: widget.isLoading ? 0 : 1,
          child: content,
        ),
        if (widget.isLoading)
          SizedBox(
            width: Dimens.iconSm + Dimens.xs,
            height: Dimens.iconSm + Dimens.xs,
            child: CircularProgressIndicator(strokeWidth: 2.2, color: fg),
          ),
      ],
    );

    final EdgeInsetsGeometry padding = widget.padding ??
        (widget.compact
            ? const EdgeInsetsDirectional.symmetric(
          horizontal: Dimens.sm,
          vertical: Dimens.xs,
        )
            : EdgeInsetsDirectional.symmetric(
          horizontal:
          widget.height < Dimens.buttonHeight ? Dimens.md : Dimens.lg,
        ));

    final inkWell = Material(
      type: MaterialType.transparency,
      child: InkWell(
        borderRadius: widget.borderRadius,
        onTap: enabled ? widget.onPressed : null,
        onHighlightChanged: (v) => _pressed.value = v,
        onHover: (v) => _hovered.value = v,
        splashColor: fg.withValues(alpha: 0.12),
        highlightColor: AppColors.transparent,
        hoverColor: AppColors.transparent,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: widget.compact ? 0 : widget.height,
          ),
          child: Padding(
            padding: padding,
            child: body,
          ),
        ),
      ),
    );

    final button = Semantics(
      button: true,
      enabled: enabled,
      label: widget.label,
      child: ListenableBuilder(
        listenable: _interaction,
        child: inkWell,
        builder: (context, child) {
          final pressed = _pressed.value;
          final hovered = _hovered.value;

          final tint = enabled
              ? (pressed
              ? fg.withValues(alpha: widget.tonal ? 0.20 : 0.12)
              : hovered
              ? fg.withValues(alpha: widget.tonal ? 0.14 : 0.06)
              : restingTint)
              : restingTint;

          return AnimatedScale(
            scale: pressed && enabled ? 0.97 : 1,
            duration: Dimens.fast,
            curve: Curves.easeOut,
            child: AnimatedContainer(
              duration: Dimens.fast,
              curve: Curves.easeOut,
              decoration: BoxDecoration(
                color: tint,
                borderRadius: widget.borderRadius,
              ),
              child: child,
            ),
          );
        },
      ),
    );

    return widget.expand
        ? SizedBox(width: double.infinity, child: button)
        : button;
  }
}