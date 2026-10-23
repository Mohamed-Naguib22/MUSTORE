import 'package:flutter/material.dart';
import 'package:mustore/core/style/dimens/dimens.dart';
import 'package:mustore/core/widgets/bottom_sheets/app_bottom_sheet.dart';
import 'package:mustore/core/widgets/buttons/app_button.dart';
import 'package:mustore/core/widgets/icons/app_icon_badge.dart';

class AppConfirmationSheet extends StatelessWidget {
  const AppConfirmationSheet({
    super.key,
    required this.title,
    required this.confirmLabel,
    required this.cancelLabel,
    this.message,
    this.icon = Icons.help_outline_rounded,
    this.isDestructive = false,
  });

  final String title;
  final String? message;
  final String confirmLabel;
  final String cancelLabel;
  final IconData icon;
  final bool isDestructive;

  static Future<bool> show(
      BuildContext context, {
        required String title,
        required String confirmLabel,
        required String cancelLabel,
        String? message,
        IconData icon = Icons.help_outline_rounded,
        bool isDestructive = false,
        bool isDismissible = true,
      }) async {
    final result = await AppBottomSheet.show<bool>(
      context,
      isDismissible: isDismissible,
      scrollable: false,
      child: AppConfirmationSheet(
        title: title,
        message: message,
        confirmLabel: confirmLabel,
        cancelLabel: cancelLabel,
        icon: icon,
        isDestructive: isDestructive,
      ),
    );
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final s = theme.colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: AppIconBadge(
            icon: icon,
            isDestructive: isDestructive,
            size: Dimens.badgeXl,
            iconSize: Dimens.iconBadgeXl,
            borderRadius: Dimens.borderLg,
          ),
        ),
        Dimens.gapLg,
        Text(
          title,
          textAlign: TextAlign.center,
          style: theme.textTheme.titleLarge?.copyWith(
            fontSize: Dimens.fontLg,
            fontWeight: FontWeight.w700,
          ),
        ),
        if (message != null) ...[
          Dimens.gapSm,
          Padding(
            padding: const EdgeInsetsDirectional.symmetric(
              horizontal: Dimens.md,
            ),
            child: Text(
              message!,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: s.onSurfaceVariant,
                height: Dimens.lineHeightRelaxed,
              ),
            ),
          ),
        ],
        Dimens.gapXl,
        AppButton(
          label: confirmLabel,
          variant: isDestructive
              ? AppButtonVariant.danger
              : AppButtonVariant.primary,
          onPressed: () => Navigator.of(context).pop(true),
        ),
        Dimens.gapSm,
        AppButton(
          label: cancelLabel,
          variant: AppButtonVariant.tonal,
          onPressed: () => Navigator.of(context).pop(false),
        ),
      ],
    );
  }
}