import 'package:flutter/material.dart';
import 'package:mustore/core/style/colors/app_colors.dart';
import 'package:mustore/core/style/dimens/dimens.dart';
import 'package:mustore/core/widgets/cards/app_card.dart';
import 'package:mustore/features/catalog/domain/entities/product/product.dart';
import 'package:mustore/features/catalog/domain/entities/product/product_sale.dart';
import 'package:mustore/features/catalog/domain/enums/currency.dart';
import 'package:mustore/features/catalog/domain/enums/sale_discount_type.dart';
import 'package:mustore/features/catalog/presentation/widgets/product/product_image_widget.dart';
import 'package:mustore/generated/l10n.dart';

const double kProductCardHeight = 270;

class ProductCardWidget extends StatelessWidget {
  const ProductCardWidget({super.key, required this.product});

  final Product product;

  static const double _wishlistSize = Dimens.xxl;
  static const int _starCount = 5;

  static const EdgeInsetsDirectional _imagePadding =
  EdgeInsetsDirectional.all(Dimens.sm);
  static const EdgeInsetsDirectional _textPadding =
  EdgeInsetsDirectional.fromSTEB(
    Dimens.sm,
    Dimens.xs,
    Dimens.sm,
    Dimens.sm,
  );

  String _price(S l10n, double value) => product.currency == CurrencyCode.egp
      ? l10n.priceEgp(value.round())
      : '${value.round()} ${product.currency.name.toUpperCase()}';

  String _discountLabel(S l10n, ProductSale sale) => switch (sale.discountType) {
    SaleDiscountType.percentage => '-${sale.discountValue.round()}%',
    SaleDiscountType.fixedAmount => '-${_price(l10n, sale.discountValue)}',
  };

  Widget _stars(ColorScheme scheme) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      for (var i = 0; i < _starCount; i++)
        Icon(
          product.rating >= i + 1
              ? Icons.star_rounded
              : product.rating >= i + 0.5
              ? Icons.star_half_rounded
              : Icons.star_outline_rounded,
          size: Dimens.iconSm,
          color: product.rating >= i + 0.5
              ? AppColors.rating
              : scheme.outline,
        ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final l10n = S.of(context);

    final sale = product.sale;
    final finalPrice = sale?.priceAfterSale ?? product.price;
    final description = product.description?.trim() ?? '';
    final reviews = product.numberOfReviews.round();

    return AppCard(
      padding: EdgeInsets.zero,
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: _imagePadding,
              child: ClipRRect(
                borderRadius: Dimens.borderSm,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    ProductImageWidget(url: product.imageUrl),
                    PositionedDirectional(
                      top: Dimens.sm,
                      start: Dimens.sm,
                      end: Dimens.sm,
                      child: Row(
                        children: [
                          if (sale != null)
                            Container(
                              padding: const EdgeInsetsDirectional.symmetric(
                                horizontal: Dimens.sm,
                                vertical: Dimens.xs,
                              ),
                              decoration: BoxDecoration(
                                color: scheme.secondary,
                                borderRadius: Dimens.borderSm,
                              ),
                              child: Text(
                                _discountLabel(l10n, sale),
                                style: text.labelSmall?.copyWith(
                                  color: scheme.onSecondary,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          const Spacer(),
                          Container(
                            width: _wishlistSize,
                            height: _wishlistSize,
                            decoration: BoxDecoration(
                              color: scheme.surface,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              product.isAddedToWishlist
                                  ? Icons.favorite_rounded
                                  : Icons.favorite_border_rounded,
                              size: Dimens.iconSm,
                              color: product.isAddedToWishlist
                                  ? scheme.error
                                  : scheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: _textPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: text.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                ),
                Dimens.gapXxs,
                Text(
                  description.isEmpty ? ' ' : description,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: text.labelSmall?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
                Dimens.gapXs,
                Visibility(
                  visible: reviews > 0,
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  child: Row(
                    children: [
                      _stars(scheme),
                      Dimens.gapXs,
                      Text(
                        '($reviews)',
                        style: text.labelSmall?.copyWith(
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                Dimens.gapSm,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Flexible(
                      child: Text(
                        _price(l10n, finalPrice),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: text.titleSmall?.copyWith(
                          color: scheme.onSurface,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    if (sale != null) ...[
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