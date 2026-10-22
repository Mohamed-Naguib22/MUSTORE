import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mustore/core/style/dimens/dimens.dart';
import 'package:mustore/core/widgets/inputs/app_input_style.dart';

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
  late final ValueNotifier<bool> _obscured =
  ValueNotifier<bool>(widget.isPassword);

  @override
  void dispose() {
    _obscured.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = Theme.of(context).colorScheme;
    final isMultiline = !widget.isPassword && widget.maxLines != 1;

    final field = ValueListenableBuilder<bool>(
      valueListenable: _obscured,
      builder: (context, obscured, _) {
        final Widget? suffix = widget.isPassword
            ? IconButton(
          onPressed: widget.enabled
              ? () => _obscured.value = !_obscured.value
              : null,
          icon: Icon(
            obscured
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
            size: Dimens.iconMd - Dimens.xs,
          ),
        )
            : widget.suffixIcon;

        return TextFormField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          enabled: widget.enabled,
          readOnly: widget.readOnly,
          autofocus: widget.autofocus,
          obscureText: obscured,
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
          style: AppInputStyle.textStyle(context, enabled: widget.enabled),
          decoration: AppInputStyle.decoration(
            context,
            hint: widget.hint,
            prefixIcon: widget.prefixIcon,
            suffixIcon: suffix,
            helperText: widget.helperText,
            errorText: widget.errorText,
            enabled: widget.enabled,
            multiline: isMultiline,
            showCounter: widget.showCounter,
            borderRadius: widget.borderRadius,
          ),
        );
      },
    );

    final Widget input = isMultiline && widget.prefixIcon != null
        ? Focus(
      canRequestFocus: false,
      skipTraversal: true,
      child: Builder(
        builder: (context) {
          final focused = Focus.of(context).hasFocus;
          final color = !widget.enabled
              ? s.onSurface.withValues(alpha: 0.38)
              : widget.errorText != null
              ? s.error
              : focused
              ? s.primary
              : s.onSurfaceVariant;
          return Stack(
            children: [
              field,
              PositionedDirectional(
                start: Dimens.lg,
                top: Dimens.md,
                child: IgnorePointer(
                  child: Icon(
                    widget.prefixIcon,
                    size: AppInputStyle.iconSize,
                    color: color,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    )
        : field;

    return AppInputStyle.labeled(
      context,
      label: widget.label,
      field: input,
    );
  }
}