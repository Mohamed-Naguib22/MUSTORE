import 'package:flutter/material.dart';
import 'package:mustore/core/style/colors/app_colors.dart';
import 'package:mustore/core/style/dimens/dimens.dart';
import 'package:mustore/core/widgets/inputs/app_input_style.dart';

class AppDropdownField<T> extends StatefulWidget {
  const AppDropdownField({
    super.key,
    required this.items,
    required this.onChanged,
    this.initialValue,
    this.label,
    this.hint,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.validator,
    this.autovalidateMode,
    this.enabled = true,
    this.borderRadius = Dimens.borderMd,
    this.menuMaxHeight = 280,
  });

  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final T? initialValue;
  final String? label;
  final String? hint;
  final String? helperText;
  final String? errorText;
  final IconData? prefixIcon;
  final FormFieldValidator<T>? validator;
  final AutovalidateMode? autovalidateMode;
  final bool enabled;
  final BorderRadius borderRadius;
  final double menuMaxHeight;

  @override
  State<AppDropdownField<T>> createState() => _AppDropdownFieldState<T>();
}

class _AppDropdownFieldState<T> extends State<AppDropdownField<T>> {
  final _menu = MenuController();
  bool _open = false;

  void _setOpen(bool value) {
    if (mounted && _open != value) setState(() => _open = value);
  }

  void _toggle() => _menu.isOpen ? _menu.close() : _menu.open();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final s = theme.colorScheme;

    final field = FormField<T>(
      initialValue: widget.initialValue,
      validator: widget.validator,
      autovalidateMode: widget.autovalidateMode,
      enabled: widget.enabled,
      builder: (state) {
        DropdownMenuItem<T>? current;
        for (final item in widget.items) {
          if (item.value == state.value) {
            current = item;
            break;
          }
        }

        return LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;

            return MenuAnchor(
              controller: _menu,
              onOpen: () => _setOpen(true),
              onClose: () => _setOpen(false),
              alignmentOffset: const Offset(0, Dimens.xs),
              style: MenuStyle(
                alignment: AlignmentDirectional.bottomStart,
                backgroundColor: WidgetStatePropertyAll(s.surfaceContainerHigh),
                surfaceTintColor: const WidgetStatePropertyAll(AppColors.transparent),
                shadowColor: const WidgetStatePropertyAll(AppColors.transparent),
                elevation: const WidgetStatePropertyAll(0),
                padding: const WidgetStatePropertyAll(EdgeInsets.all(Dimens.xs)),
                maximumSize: WidgetStatePropertyAll(Size(double.infinity, widget.menuMaxHeight)),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: widget.borderRadius,
                    side: BorderSide(color: s.outlineVariant),
                  ),
                ),
              ),
              menuChildren: [
                for (final item in widget.items)
                  SizedBox(
                    width: width - Dimens.xs * 2,
                    child: _OptionTile<T>(
                      item: item,
                      selected: item.value == state.value,
                      radius: widget.borderRadius,
                      onSelected: () {
                        item.onTap?.call();
                        state.didChange(item.value);
                        widget.onChanged?.call(item.value);
                      },
                    ),
                  ),
              ],
              child: MouseRegion(
                cursor: widget.enabled ? SystemMouseCursors.click : MouseCursor.defer,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: widget.enabled ? _toggle : null,
                  child: InputDecorator(
                    isEmpty: current == null,
                    isFocused: _open,
                    baseStyle: AppInputStyle.textStyle(context, enabled: widget.enabled),
                    decoration: AppInputStyle.decoration(
                      context,
                      hint: widget.hint,
                      prefixIcon: widget.prefixIcon,
                      helperText: widget.helperText,
                      errorText: state.errorText ?? widget.errorText,
                      enabled: widget.enabled,
                      borderRadius: widget.borderRadius,
                      suffixIcon: AnimatedRotation(
                        turns: _open ? 0.5 : 0,
                        duration: const Duration(milliseconds: 180),
                        child: const Icon(Icons.keyboard_arrow_down_rounded),
                      ),
                    ),
                    child: current?.child,
                  ),
                ),
              ),
            );
          },
        );
      },
    );

    return AppInputStyle.labeled(
      context,
      label: widget.label,
      field: field,
    );
  }
}

class _OptionTile<T> extends StatelessWidget {
  const _OptionTile({
    required this.item,
    required this.selected,
    required this.radius,
    required this.onSelected,
  });

  final DropdownMenuItem<T> item;
  final bool selected;
  final BorderRadius radius;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final s = theme.colorScheme;

    final foreground = WidgetStateProperty.resolveWith<Color>((states) {
      if (states.contains(WidgetState.disabled)) {
        return s.onSurface.withValues(alpha: 0.38);
      }
      return selected ? s.primary : s.onSurface;
    });

    return MenuItemButton(
      onPressed: item.enabled ? onSelected : null,
      requestFocusOnHover: false,
      trailingIcon: selected ? const Icon(Icons.check_rounded) : null,
      style: ButtonStyle(
        foregroundColor: foreground,
        iconColor: foreground,
        iconSize: const WidgetStatePropertyAll(Dimens.iconMd - Dimens.xs),
        backgroundColor: WidgetStatePropertyAll(
          selected ? s.primary.withValues(alpha: 0.12) : AppColors.transparent,
        ),
        overlayColor: WidgetStatePropertyAll(s.primary.withValues(alpha: 0.08)),
        minimumSize: const WidgetStatePropertyAll(Size.fromHeight(48)),
        padding: const WidgetStatePropertyAll(
          EdgeInsetsDirectional.symmetric(horizontal: Dimens.md),
        ),
        shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: radius)),
        textStyle: WidgetStatePropertyAll(
          theme.textTheme.bodyMedium?.copyWith(
            fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ),
      child: item.child,
    );
  }
}