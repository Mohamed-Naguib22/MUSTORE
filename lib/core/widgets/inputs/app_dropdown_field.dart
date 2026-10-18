import 'package:flutter/material.dart';
import 'package:mustore/core/style/colors/app_colors.dart';
import 'package:mustore/core/style/dimens/dimens.dart';
import 'package:mustore/core/widgets/inputs/app_input_style.dart';

class AppDropdownField<T> extends StatelessWidget {
  const AppDropdownField({
    super.key,
    required this.items,
    required this.onChanged,
    this.value,
    this.label,
    this.hint,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.validator,
    this.autovalidateMode,
    this.enabled = true,
    this.borderRadius = Dimens.borderMd,
  });

  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final T? value;
  final String? label;
  final String? hint;
  final String? helperText;
  final String? errorText;
  final IconData? prefixIcon;
  final FormFieldValidator<T>? validator;
  final AutovalidateMode? autovalidateMode;
  final bool enabled;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final s = theme.colorScheme;

    final field = DropdownButtonFormField<T>(
      value: value,
      items: items,
      onChanged: enabled ? onChanged : null,
      validator: validator,
      autovalidateMode: autovalidateMode,
      isExpanded: true,
      borderRadius: borderRadius,
      dropdownColor: s.surface,
      focusColor: AppColors.transparent,
      icon: Icon(Icons.keyboard_arrow_down_rounded, color: s.onSurfaceVariant),
      style: AppInputStyle.textStyle(context, enabled: enabled),
      hint: hint == null
          ? null
          : Text(
        hint!,
        style: theme.textTheme.bodyLarge?.copyWith(
          color: s.onSurfaceVariant.withValues(alpha: 0.7),
        ),
      ),
      decoration: AppInputStyle.decoration(
        context,
        prefixIcon: prefixIcon,
        helperText: helperText,
        errorText: errorText,
        enabled: enabled,
        borderRadius: borderRadius,
      ),
    );

    return AppInputStyle.labeled(
      context,
      label: label,
      enabled: enabled,
      field: field,
    );
  }
}