import 'package:flutter/material.dart';
import 'package:mustore/core/style/dimens/dimens.dart';
import 'package:mustore/core/widgets/buttons/app_text_button.dart';
import 'package:mustore/generated/l10n.dart';

class HomeSectionHeaderWidget extends StatelessWidget {
  const HomeSectionHeaderWidget({super.key, required this.title, this.onSeeAll});

  final String title;
  final VoidCallback? onSeeAll;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Dimens.section,
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          if (onSeeAll != null)
            AppTextButton(
              label: S.of(context).homeSeeAll,
              onPressed: onSeeAll,
              compact: true,
            ),
        ],
      ),
    );
  }
}