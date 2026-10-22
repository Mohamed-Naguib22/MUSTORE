import 'package:flutter/material.dart';
import 'package:mustore/core/style/dimens/dimens.dart';
import 'package:mustore/core/widgets/buttons/app_text_button.dart'; // adjust path
import 'package:mustore/core/widgets/cards/app_card.dart';

class AppMessageWidget extends StatelessWidget {
  const AppMessageWidget({
    super.key,
    required this.message,
    this.title,
    this.icon = Icons.cloud_off_rounded,
    this.actionLabel,
    this.onAction,
    this.isActionLoading = false,
    this.margin = Dimens.screenH,
  });

  final String message;
  final String? title;
  final IconData icon;
  final String? actionLabel;
  final VoidCallback? onAction;
  final bool isActionLoading;
  final EdgeInsetsGeometry margin;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final hasAction = actionLabel != null && onAction != null;

    return AppCard(
      variant: AppCardVariant.filled,
      color: scheme.errorContainer.withValues(alpha: 0.45),
      margin: margin,
      borderColor: scheme.onErrorContainer.withValues(alpha: 0.15),
      borderRadius: Dimens.borderMd,
      child: Row(
        children: [
          Container(
            width: Dimens.iconLg,
            height: Dimens.iconLg,
            decoration: BoxDecoration(
              color: scheme.errorContainer,
              borderRadius: Dimens.borderSm,
            ),
            child: Icon(
              icon,
              size: Dimens.iconMd,
              color: scheme.onErrorContainer,
            ),
          ),
          Dimens.gapMd,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (title != null)
                  Text(
                    title!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: scheme.onErrorContainer,
                    ),
                  ),
                Text(
                  message,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: scheme.onErrorContainer.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          ),
          if (hasAction) ...[
            Dimens.gapSm,
            AppTextButton(
              label: actionLabel!,
              icon: Icons.refresh_rounded,
              onPressed: onAction,
              isLoading: isActionLoading,
              foregroundColor: scheme.onErrorContainer,
              compact: true,
              borderRadius: Dimens.borderPill,
            ),
          ],
        ],
      ),
    );
  }
}