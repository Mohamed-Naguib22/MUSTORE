import 'package:flutter/material.dart';
import 'package:mustore/core/services/localization/language_codes.dart';
import 'package:mustore/core/style/dimens/dimens.dart';
import 'package:mustore/core/widgets/cards/app_card.dart';
import 'package:mustore/core/widgets/lists/app_divider.dart';

class AccountSectionWidget extends StatelessWidget {
  const AccountSectionWidget({
    super.key,
    required this.title,
    required this.children,
  });

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isArabic =
        Localizations.localeOf(context).languageCode == LanguageCodes.ar;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.only(
            start: Dimens.sm,
            top: Dimens.lg,
            bottom: Dimens.sm,
          ),
          child: Text(
            isArabic ? title : title.toUpperCase(),
            style: theme.textTheme.labelMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w600,
              letterSpacing: isArabic ? 0 : 0.8,
            ),
          ),
        ),
        AppCard(
          padding: const EdgeInsetsDirectional.symmetric(vertical: Dimens.xs),
          child: Column(
            children: [
              for (var i = 0; i < children.length; i++) ...[
                if (i > 0) const AppDivider.listTile(),
                children[i],
              ],
            ],
          ),
        ),
      ],
    );
  }
}