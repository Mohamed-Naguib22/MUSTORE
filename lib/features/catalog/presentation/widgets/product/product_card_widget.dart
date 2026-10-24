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
const double kProductCardWidth = 170;

class ProductCardWidget extends StatelessWidget {
  const ProductCardWidget({super.key, required this.product});

  final Product product;

  static const double _wishlistSize = Dimens.xxl;
  static const double _chipAlpha = 0.92;

  static const EdgeInsetsDirectional _imagePadding =
  EdgeInsetsDirectional.all(Dimens.sm);
  static const EdgeInsetsDirectional _textPadding =
  EdgeInsetsDirectional.fromSTEB(
    Dimens.md,
    Dimens.xs,
    Dimens.md,
    Dimens.md,
  );
  static const EdgeInsetsDirectional _pillPadding =
  EdgeInsetsDirectional.symmetric(
    horizontal: Dimens.sm,
    vertical: Dimens.xs,
  );

  String _price(S l10n, double value) => product.currency == CurrencyCode.egp
      ? l10n.priceEgp(value.round())
      : '${value.round()} ${product.currency.name.toUpperCase()}';

  String _discountLabel(ProductSale sale, double saved) {
    final percent = switch (sale.discountType) {
      SaleDiscountType.percentage => sale.discountValue,
      SaleDiscountType.fixedAmount =>
      product.price > 0 ? saved / product.price * 100 : 0.0,
    };
    return '-${percent.round()}%';
  }

  Widget _saleTag(ColorScheme scheme, TextTheme text, String label) =>
      Container(
        padding: _pillPadding,
        decoration: BoxDecoration(
          color: scheme.secondary,
          borderRadius: Dimens.borderPill,
        ),
        child: Text(
          label,
          style: text.labelSmall?.copyWith(
            color: scheme.onSecondary,
            fontWeight: FontWeight.w700,
          ),
        ),
      );

  Widget _wishlistButton(ColorScheme scheme) => Container(
    width: _wishlistSize,
    height: _wishlistSize,
    decoration: BoxDecoration(
      color: scheme.surface.withValues(alpha: _chipAlpha),
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
  );

  Widget _ratingChip(ColorScheme scheme, TextTheme text, int reviews) =>
      Container(
        padding: _pillPadding,
        decoration: BoxDecoration(
          color: scheme.surface.withValues(alpha: _chipAlpha),
          borderRadius: Dimens.borderPill,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.star_rounded,
              size: Dimens.iconSm,
              color: AppColors.rating,
            ),
            Dimens.gapXxs,
            Text(
              product.rating.toStringAsFixed(1),
              style: text.labelSmall?.copyWith(
                color: scheme.onSurface,
                fontWeight: FontWeight.w700,
              ),
            ),
            Dimens.gapXs,
            Text(
              '($reviews)',
              style: text.labelSmall?.copyWith(
                color: scheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final l10n = S.of(context);

    final sale = product.sale;
    final finalPrice = sale?.priceAfterSale ?? product.price;
    final saved = (product.price - finalPrice).clamp(0.0, double.infinity);
    final description = product.description?.trim() ?? '';
    final reviews = product.numberOfReviews.round();

    return AppCard(
      variant: AppCardVariant.filled,
      color: scheme.surface,
      borderColor: AppColors.transparent,
      padding: EdgeInsets.zero,
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: _imagePadding,
              child: ClipRRect(
                borderRadius: Dimens.borderMd,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    ColoredBox(color: scheme.surfaceContainer),
                    ProductImageWidget(url: product.imageUrl),
                    PositionedDirectional(
                      top: Dimens.sm,
                      start: Dimens.sm,
                      end: Dimens.sm,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Align(
                              alignment: AlignmentDirectional.centerStart,
                              child: sale == null
                                  ? const SizedBox.shrink()
                                  : _saleTag(
                                scheme,
                                text,
                                _discountLabel(sale, saved),
                              ),
                            ),
                          ),
                          Dimens.gapXs,
                          _wishlistButton(scheme),
                        ],
                      ),
                    ),
                    if (reviews > 0)
                      PositionedDirectional(
                        bottom: Dimens.sm,
                        start: Dimens.sm,
                        child: _ratingChip(scheme, text, reviews),
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
                Dimens.gapSm,
                SizedBox(
                  width: double.infinity,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: AlignmentDirectional.centerStart,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          _price(l10n, finalPrice),
                          maxLines: 1,
                          style: text.titleSmall?.copyWith(
                            color:
                            sale == null ? scheme.onSurface : scheme.error,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        if (sale != null) ...[
                          Dimens.gapSm,
                          Text(
                            _price(l10n, product.price),
                            maxLines: 1,
                            style: text.labelSmall?.copyWith(
                              color: scheme.onSurfaceVariant,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}