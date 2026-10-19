import 'package:flutter/material.dart';
import 'package:mustore/core/style/dimens/dimens.dart';
import 'package:mustore/core/widgets/cards/app_card.dart';
import 'package:mustore/core/widgets/media/app_network_image.dart';
import 'package:mustore/features/catalog/domain/entities/category/category.dart';

class CategoryListWidget extends StatelessWidget {
  const CategoryListWidget({
    super.key,
    required this.categories,
    this.onTap,
  });

  final List<Category> categories;
  final ValueChanged<Category>? onTap;

  static const double _avatar = Dimens.xxxl + Dimens.md;
  static const double _itemWidth = _avatar + Dimens.sm;
  static const double _height = _avatar + Dimens.sm + Dimens.xl;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return SizedBox(
      height: _height,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: Dimens.screenH,
        itemCount: categories.length,
        separatorBuilder: (_, __) => Dimens.gapMd,
        itemBuilder: (_, i) {
          final c = categories[i];

          return SizedBox(
            width: _itemWidth,
            child: Column(
              children: [
                AppCard(
                  variant: AppCardVariant.filled,
                  color: scheme.primaryContainer,
                  borderRadius: Dimens.borderPill,
                  width: _avatar,
                  height: _avatar,
                  padding: EdgeInsets.zero,
                  onTap: onTap == null ? null : () => onTap!(c),
                  child: AppNetworkImage(
                    url: c.imageUrl,
                    iconSize: Dimens.iconMd,
                    iconColor: scheme.onPrimaryContainer,
                    backgroundColor: scheme.primaryContainer,
                  ),
                ),
                Dimens.gapSm,
                Text(
                  c.name,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: scheme.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}