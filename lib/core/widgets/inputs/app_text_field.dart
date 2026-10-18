import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mustore/core/style/dimens/dimens.dart';
import 'package:mustore/core/style/colors/app_colors.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.label,
    this.hint,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.isPassword = false,
    this.enabled = true,
    this.readOnly = false,
    this.autofocus = false,
    this.keyboardType,
    this.textInputAction,
    this.textDirection,
    this.textAlign = TextAlign.start,
    this.inputFormatters,
    this.autofillHints,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.showCounter = false,
    this.validator,
    this.autovalidateMode,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.borderRadius = Dimens.borderMd,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? label;
  final String? hint;
  final String? helperText;
  final String? errorText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final bool isPassword;
  final bool enabled;
  final bool readOnly;
  final bool autofocus;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextDirection? textDirection;
  final TextAlign textAlign;

  final List<TextInputFormatter>? inputFormatters;
  final Iterable<String>? autofillHints;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final bool showCounter;

  final FormFieldValidator<String>? validator;
  final AutovalidateMode? autovalidateMode;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onTap;

  final BorderRadius borderRadius;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool _obscured = widget.isPassword;

  OutlineInputBorder _border(Color color, {double width = 1}) => OutlineInputBorder(
    borderRadius: widget.borderRadius,
    borderSide: BorderSide(color: color, width: width),
  );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final s = theme.colorScheme;
    final text = theme.textTheme;

    final iconColor = WidgetStateColor.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) return s.onSurface.withValues(alpha: 0.38);
      if (states.contains(WidgetState.error)) return s.error;
      if (states.contains(WidgetState.focused)) return s.primary;
      return s.onSurfaceVariant;
    });

    final isMultiline = !widget.isPassword && widget.maxLines != 1;

    Widget? suffix;
    if (widget.isPassword) {
      suffix = IconButton(
        onPressed: widget.enabled ? () => setState(() => _obscured = !_obscured) : null,
        icon: Icon(
          _obscured ? Icons.visibility_off_outlined : Icons.visibility_outlined,
          size: Dimens.iconMd - Dimens.xs,
        ),
      );
    } else {
      suffix = widget.suffixIcon;
    }

    final field = TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      enabled: widget.enabled,
      readOnly: widget.readOnly,
      autofocus: widget.autofocus,
      obscureText: _obscured,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      textDirection: widget.textDirection,
      textAlign: widget.textAlign,
      inputFormatters: widget.inputFormatters,
      autofillHints: widget.autofillHints,
      maxLines: widget.isPassword ? 1 : widget.maxLines,
      minLines: widget.isPassword ? null : widget.minLines,
      maxLength: widget.maxLength,
      validator: widget.validator,
      autovalidateMode: widget.autovalidateMode,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onSubmitted,
      onTap: widget.onTap,
      cursorColor: s.primary,
      style: text.bodyLarge?.copyWith(
        color: widget.enabled ? s.onSurface : s.onSurface.withValues(alpha: 0.38),
      ),
      decoration: InputDecoration(
        hintText: widget.hint,
        hintStyle: text.bodyLarge?.copyWith(color: s.onSurfaceVariant.withValues(alpha: 0.7)),
        helperText: widget.helperText,
        helperStyle: text.bodySmall?.copyWith(color: s.onSurfaceVariant),
        helperMaxLines: 2,
        errorText: widget.errorText,
        errorStyle: text.bodySmall?.copyWith(color: s.error),
        errorMaxLines: 2,
        counterText: widget.showCounter ? null : '',
        filled: true,
        fillColor: widget.enabled
            ? s.surfaceContainerHighest
            : s.surfaceContainerHighest.withValues(alpha: 0.5),
        prefixIcon: widget.prefixIcon == null
            ? null
            : Icon(widget.prefixIcon, size: Dimens.iconMd - Dimens.xs),
        prefixIconColor: iconColor,
        suffixIcon: suffix,
        suffixIconColor: iconColor,
        contentPadding: const EdgeInsetsDirectional.symmetric(
          horizontal: Dimens.lg,
          vertical: Dimens.md,
        ),
        constraints: isMultiline ? null : const BoxConstraints(minHeight: Dimens.buttonHeight),
        border: _border(AppColors.transparent),
        enabledBorder: _border(AppColors.transparent),
        disabledBorder: _border(AppColors.transparent),
        focusedBorder: _border(s.primary, width: 1.5),
        errorBorder: _border(s.error),
        focusedErrorBorder: _border(s.error, width: 1.5),
      ),
    );

    if (widget.label == null) return field;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.only(start: Dimens.xs),
          child: Text(
            widget.label!,
            style: text.labelLarge?.copyWith(
              color: widget.enabled ? s.onSurface : s.onSurface.withValues(alpha: 0.38),
            ),
          ),
        ),
        Dimens.gapSm,
        field,
      ],
    );
  }
}