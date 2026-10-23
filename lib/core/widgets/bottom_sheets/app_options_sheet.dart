import 'package:flutter/material.dart';
import 'package:mustore/core/style/dimens/dimens.dart';
import 'package:mustore/core/widgets/bottom_sheets/app_bottom_sheet.dart';
import 'package:mustore/core/widgets/lists/app_divider.dart';
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
      padding: const EdgeInsetsDirectional.symmetric(horizontal: Dimens.sm),
      child: AppOptionsSheet<T>(options: options),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < options.length; i++) ...[
          if (i > 0)
            options[i].icon != null
                ? const AppDivider.listTile()
                : const AppDivider(indent: Dimens.lg),
          AppListTile(
            icon: options[i].icon,
            title: options[i].label,
            isDestructive: options[i].isDestructive,
            showChevron: false,
            onTap: () => Navigator.of(context).pop(options[i].value),
          ),
        ],
      ],
    );
  }
}