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

  @override
  State<AppTextButton> createState() => _AppTextButtonState();
}

class _AppTextButtonState extends State<AppTextButton> {
  bool _pressed = false;
  bool _hovered = false;

  Color _foreground(ColorScheme s, bool interactive) {
    if (!interactive) return s.onSurface.withValues(alpha: 0.38);
    if (widget.foregroundColor != null) return widget.foregroundColor!;
    return switch (widget.variant) {
      AppTextButtonVariant.primary => s.primary,
      AppTextButtonVariant.secondary => s.secondary,
      AppTextButtonVariant.danger => s.error,
      AppTextButtonVariant.neutral => s.onSurface,
    };
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
    ) ?? const TextStyle()).copyWith(color: fg);
    final iconSize = Dimens.iconMd - Dimens.xs;

    final tint = enabled
        ? (_pressed
        ? fg.withValues(alpha: 0.12)
        : _hovered
        ? fg.withValues(alpha: 0.06)
        : AppColors.transparent)
        : AppColors.transparent;

    final content = Row(
      mainAxisSize: widget.expand ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.icon != null) ...[
          Icon(widget.icon, size: iconSize, color: fg),
          Dimens.gapSm,
        ],
        Flexible(
          child: Text(
            widget.label,
            style: textStyle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (widget.trailingIcon != null) ...[
          Dimens.gapSm,
          Icon(widget.trailingIcon, size: iconSize, color: fg),
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

    final padding = widget.compact
        ? const EdgeInsetsDirectional.symmetric(
      horizontal: Dimens.sm,
      vertical: Dimens.xs,
    )
        : EdgeInsetsDirectional.symmetric(
      horizontal: widget.height < Dimens.buttonHeight ? Dimens.md : Dimens.lg,
    );

    final button = Semantics(
      button: true,
      enabled: enabled,
      label: widget.label,
      child: AnimatedScale(
        scale: _pressed && enabled ? 0.97 : 1,
        duration: Dimens.fast,
        curve: Curves.easeOut,
        child: AnimatedContainer(
          duration: Dimens.fast,
          curve: Curves.easeOut,
          decoration: BoxDecoration(
            color: tint,
            borderRadius: widget.borderRadius,
          ),
          child: Material(
            type: MaterialType.transparency,
            child: InkWell(
              borderRadius: widget.borderRadius,
              onTap: enabled ? widget.onPressed : null,
              onHighlightChanged: (v) => setState(() => _pressed = v),
              onHover: (v) => setState(() => _hovered = v),
              splashColor: fg.withValues(alpha: 0.12),
              highlightColor: AppColors.transparent,
              hoverColor: AppColors.transparent,
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: widget.compact ? 0 : widget.height),
                child: Padding(
                  padding: padding,
                  child: body,
                ),
              ),
            ),
          ),
        ),
      ),
    );

    return widget.expand ? SizedBox(width: double.infinity, child: button) : button;
  }
}