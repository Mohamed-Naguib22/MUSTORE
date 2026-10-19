import 'package:flutter/material.dart';
import 'package:mustore/core/style/dimens/dimens.dart';
import 'package:mustore/core/widgets/cards/app_card.dart';
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

    final fallback = Center(
      child: Icon(
        Icons.category_rounded,
        size: Dimens.iconMd,
        color: scheme.onPrimaryContainer,
      ),
    );

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
                  child: c.imageUrl.isEmpty
                      ? fallback
                      : Image.network(
                    c.imageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    frameBuilder: (_, child, frame, sync) =>
                        AnimatedOpacity(
                          opacity: sync || frame != null ? 1 : 0,
                          duration: Dimens.normal,
                          child: child,
                        ),
                    errorBuilder: (_, __, ___) => fallback,
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