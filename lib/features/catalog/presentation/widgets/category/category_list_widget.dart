import 'package:flutter/material.dart';
import 'package:mustore/core/style/dimens/dimens.dart';
import 'package:mustore/core/widgets/cards/app_card.dart';
import 'package:mustore/features/home/presentation/screens/home_screen.dart';

class CategoryListWidget extends StatelessWidget {
  const CategoryListWidget({super.key, required this.categories});

  final List<HomeCategory> categories;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return SizedBox(
      height: 92,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: Dimens.screenH,
        itemCount: categories.length,
        separatorBuilder: (_, __) => Dimens.gapLg,
        itemBuilder: (_, i) {
          final c = categories[i];
          return SizedBox(
            width: 68,
            child: Column(
              children: [
                AppCard(
                  variant: AppCardVariant.filled,
                  width: 60,
                  height: 60,
                  padding: EdgeInsets.zero,
                  onTap: () {},
                  child: Center(child: Icon(c.icon, color: scheme.primary)),
                ),
                Dimens.gapXs,
                Text(
                  c.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}