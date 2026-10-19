import 'package:flutter/material.dart';
import 'package:mustore/core/style/dimens/dimens.dart';
import 'package:mustore/core/style/colors/app_colors.dart';

enum AppButtonVariant { primary, secondary, tonal, danger }

class AppButton extends StatefulWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.leading,
    this.trailing,
    this.trailingIcon,
    this.variant = AppButtonVariant.primary,
    this.isLoading = false,
    this.isEnabled,
    this.backgroundColor,
    this.foregroundColor,
    this.expand = true,
    this.height = Dimens.buttonHeight,
    this.borderRadius = Dimens.borderMd,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final Widget? leading;
  final Widget? trailing;
  final IconData? trailingIcon;
  final AppButtonVariant variant;
  final bool isLoading;
  final ValueNotifier<bool>? isEnabled;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final bool expand;
  final double height;
  final BorderRadius borderRadius;

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  bool _pressed = false;

  ({Color bg, Color fg}) _colors(ColorScheme s, bool interactive) {
    if (!interactive) {
      return (
      bg: s.onSurface.withValues(alpha: 0.12),
      fg: s.onSurface.withValues(alpha: 0.38),
      );
    }
    final base = switch (widget.variant) {
      AppButtonVariant.primary => (bg: s.primary, fg: s.onPrimary),
      AppButtonVariant.secondary => (bg: s.secondary, fg: s.onSecondary),
      AppButtonVariant.danger => (bg: s.error, fg: s.onError),
      AppButtonVariant.tonal => (
      bg: s.primary.withValues(alpha: 0.12),
      fg: s.primary,
      ),
    };
    return (
    bg: widget.backgroundColor ?? base.bg,
    fg: widget.foregroundColor ?? base.fg,
    );
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
    final c = _colors(theme.colorScheme, interactive);
    final textStyle =
    (theme.textTheme.labelLarge ?? const TextStyle()).copyWith(color: c.fg);

    final content = Row(
      mainAxisSize: widget.expand ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.leading != null) ...[
          widget.leading!,
          Dimens.gapSm,
        ] else if (widget.icon != null) ...[
          Icon(widget.icon, size: Dimens.iconMd - Dimens.xs, color: c.fg),
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
        if (widget.trailing != null) ...[
          Dimens.gapSm,
          widget.trailing!,
        ] else if (widget.trailingIcon != null) ...[
          Dimens.gapSm,
          Icon(widget.trailingIcon,
              size: Dimens.iconMd - Dimens.xs, color: c.fg),
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
            child: CircularProgressIndicator(strokeWidth: 2.2, color: c.fg),
          ),
      ],
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
            color: c.bg,
            borderRadius: widget.borderRadius,
          ),
          child: Material(
            type: MaterialType.transparency,
            child: InkWell(
              borderRadius: widget.borderRadius,
              onTap: enabled ? widget.onPressed : null,
              onHighlightChanged: (v) => setState(() => _pressed = v),
              splashColor: c.fg.withValues(alpha: 0.12),
              highlightColor: AppColors.transparent,
              hoverColor: c.fg.withValues(alpha: 0.06),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: widget.height),
                child: Padding(
                  padding: EdgeInsetsDirectional.symmetric(
                    horizontal: widget.height < Dimens.buttonHeight
                        ? Dimens.lg
                        : Dimens.xl,
                  ),
                  child: body,
                ),
              ),
            ),
          ),
        ),
      ),
    );

    return widget.expand
        ? SizedBox(width: double.infinity, child: button)
        : button;
  }
}