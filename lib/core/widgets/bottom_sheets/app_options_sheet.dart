import 'package:flutter/material.dart';
import 'package:mustore/core/widgets/bottom_sheets/app_bottom_sheet.dart';
import 'package:mustore/core/widgets/lists/app_list_tile.dart';

class AppOption<T> {
  const AppOption({
    required this.value,
    required this.label,
    this.icon,
    this.isDestructive = false,
  });

  final T value;
  final String label;
  final IconData? icon;
  final bool isDestructive;
}

class AppOptionsSheet<T> extends StatelessWidget {
  const AppOptionsSheet({super.key, required this.options});

  final List<AppOption<T>> options;

  static Future<T?> show<T>(
      BuildContext context, {
        required List<AppOption<T>> options,
        bool isDismissible = true,
      }) {
    return AppBottomSheet.show<T>(
      context,
      isDismissible: isDismissible,
      padding: EdgeInsets.zero,
      child: AppOptionsSheet<T>(options: options),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final option in options)
          AppListTile(
            icon: option.icon,
            title: option.label,
            isDestructive: option.isDestructive,
            showChevron: false,
            onTap: () => Navigator.of(context).pop(option.value),
          ),
      ],
    );
  }
}