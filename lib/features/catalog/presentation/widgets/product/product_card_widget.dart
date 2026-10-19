import 'package:flutter/material.dart';
import 'package:mustore/core/style/colors/app_colors.dart';
import 'package:mustore/core/style/dimens/dimens.dart';
import 'package:mustore/core/widgets/cards/app_card.dart';
import 'package:mustore/features/catalog/domain/entities/product/product.dart';
import 'package:mustore/features/catalog/presentation/widgets/product/product_image_widget.dart';
import 'package:mustore/generated/l10n.dart';

const double kProductCardHeight = 270;

class ProductCardWidget extends StatelessWidget {
  const ProductCardWidget({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final l10n = S.of(context);

    final sale = product.sale;
    final int? discountPercent = (sale == null || product.price <= 0)
        ? null
        : ((product.price - sale.priceAfterSale) / product.price * 100)
        .round();
    final finalPrice = sale?.priceAfterSale ?? product.price;

    return AppCard(
      padding: EdgeInsets.zero,
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                ProductImageWidget(url: product.imageUrl),
                if (discountPercent != null)
                  PositionedDirectional(
                    top: Dimens.sm,
                    start: Dimens.sm,
                    child: Container(
                      padding: const EdgeInsetsDirectional.symmetric(
                        horizontal: Dimens.sm,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: scheme.secondary,
                        borderRadius: Dimens.borderSm,
                      ),
                      child: Text(
                        '-$discountPercent%',
                        style: text.labelSmall?.copyWith(
                          color: scheme.onSecondary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                PositionedDirectional(
                  top: Dimens.xs,
                  end: Dimens.xs,
                  child: IconButton.filled(
                    onPressed: () {},
                    visualDensity: VisualDensity.compact,
                    style: IconButton.styleFrom(
                      backgroundColor: scheme.surface.withValues(alpha: 0.92),
                      foregroundColor: scheme.onSurface,
                    ),
                    icon: Icon(
                      product.isAddedToWishlist
                          ? Icons.favorite_rounded
                          : Icons.favorite_border_rounded,
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: Dimens.cardPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: text.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                ),
                Dimens.gapXs,
                Row(
                  children: [
                    const Icon(
                      Icons.star_rounded,
                      size: Dimens.iconSm,
                      color: AppColors.rating,
                    ),
                    Dimens.gapXxs,
                    Text(
                      product.rating.toStringAsFixed(1),
                      style: text.labelMedium,
                    ),
                  ],
                ),
                Dimens.gapXs,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      l10n.priceEgp(finalPrice.round()),
                      style: text.titleSmall?.copyWith(
                        color: scheme.primary,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    if (discountPercent != null) ...[
                      Dimens.gapSm,
                      Text(
                        product.price.toStringAsFixed(0),
                        style: text.labelSmall?.copyWith(
                          color: scheme.onSurfaceVariant,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}