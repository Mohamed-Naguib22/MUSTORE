import 'package:flutter/material.dart';
import 'package:mustore/core/style/colors/app_colors.dart';
import 'package:mustore/core/style/dimens/dimens.dart';

abstract final class AppInputStyle {
  static InputDecoration decoration(
      BuildContext context, {
        String? hint,
        IconData? prefixIcon,
        Widget? suffixIcon,
        String? helperText,
        String? errorText,
        bool enabled = true,
        bool multiline = false,
        bool showCounter = false,
        BorderRadius borderRadius = Dimens.borderMd,
      }) {
    final theme = Theme.of(context);
    final s = theme.colorScheme;
    final text = theme.textTheme;

    OutlineInputBorder border(Color color, {double width = 1}) => OutlineInputBorder(
      borderRadius: borderRadius,
      borderSide: BorderSide(color: color, width: width),
    );

    final iconColor = WidgetStateColor.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) return s.onSurface.withValues(alpha: 0.38);
      if (states.contains(WidgetState.error)) return s.error;
      if (states.contains(WidgetState.focused)) return s.primary;
      return s.onSurfaceVariant;
    });

    return InputDecoration(
      hintText: hint,
      hintStyle: text.bodyMedium?.copyWith(color: s.onSurfaceVariant.withValues(alpha: 0.7)),
      helperText: helperText,
      helperStyle: text.bodySmall?.copyWith(color: s.onSurfaceVariant),
      helperMaxLines: 2,
      errorText: errorText,
      errorStyle: text.bodySmall?.copyWith(color: s.error),
      errorMaxLines: 2,
      counterText: showCounter ? null : '',
      filled: true,
      fillColor: enabled
          ? s.surfaceContainerHighest
          : s.surfaceContainerHighest.withValues(alpha: 0.5),
      prefixIcon: prefixIcon == null
          ? null
          : Icon(prefixIcon, size: Dimens.iconMd - Dimens.xs),
      prefixIconColor: iconColor,
      suffixIcon: suffixIcon,
      suffixIconColor: iconColor,
      contentPadding: const EdgeInsetsDirectional.symmetric(
        horizontal: Dimens.lg,
        vertical: Dimens.md,
      ),
      constraints: multiline ? null : const BoxConstraints(minHeight: Dimens.buttonHeight),
      border: border(AppColors.transparent),
      enabledBorder: border(AppColors.transparent),
      disabledBorder: border(AppColors.transparent),
      focusedBorder: border(s.primary, width: 1.5),
      errorBorder: border(s.error),
      focusedErrorBorder: border(s.error, width: 1.5),
    );
  }

  static TextStyle? textStyle(BuildContext context, {bool enabled = true}) {
    final theme = Theme.of(context);
    final s = theme.colorScheme;
    return theme.textTheme.bodyLarge?.copyWith(
      color: enabled ? s.onSurface : s.onSurface.withValues(alpha: 0.38),
    );
  }

  static Widget labeled(
      BuildContext context, {
        required String? label,
        required bool enabled,
        required Widget field,
      }) {
    if (label == null) return field;

    final theme = Theme.of(context);
    final s = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.only(start: Dimens.xs),
          child: Text(
            label,
            style: theme.textTheme.labelLarge?.copyWith(
              color: enabled ? s.onSurface : s.onSurface.withValues(alpha: 0.38),
            ),
          ),
        ),
        Dimens.gapSm,
        field,
      ],
    );
  }
}