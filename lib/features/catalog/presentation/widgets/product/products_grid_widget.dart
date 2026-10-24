import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:mustore/core/style/dimens/dimens.dart';
import 'package:mustore/core/widgets/loading/app_skeleton.dart';
import 'package:mustore/features/catalog/domain/entities/product/product.dart';
import 'package:mustore/features/catalog/presentation/widgets/product/product_card_widget.dart';

class ProductsGridWidget extends StatelessWidget {
  const ProductsGridWidget({
    super.key,
    required this.products,
    this.controller,
    this.isLoading = false,
    this.loadingMore = false,
  });

  final List<Product> products;
  final ScrollController? controller;
  final bool isLoading;
  final bool loadingMore;

  static const _columns = 2;
  static const _gap = Dimens.md;
  static const _imageRatio = 1.2;

  @override
  Widget build(BuildContext context) {
    final items = isLoading ? Product.fakeList() : products;
    final extra = loadingMore ? _columns : 0;
    final padding = Dimens.screen.copyWith(
      bottom: Dimens.lg + MediaQuery.paddingOf(context).bottom,
    );

    return AppSkeleton(
      isLoading: isLoading,
      child: LayoutBuilder(
        builder: (context, box) {
          final cardWidth =
              (box.maxWidth - padding.horizontal - _gap * (_columns - 1)) /
                  _columns;
          final cardHeight = math.max(
            kProductCardHeight,
            kProductCardHeight + (cardWidth - kProductCardWidth) * _imageRatio,
          );

          return GridView.builder(
            controller: controller,
            physics: const AlwaysScrollableScrollPhysics(),
            padding: padding,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: _columns,
              mainAxisExtent: cardHeight,
              mainAxisSpacing: _gap,
              crossAxisSpacing: _gap,
            ),
            itemCount: items.length + extra,
            itemBuilder: (_, i) => i < items.length
                ? ProductCardWidget(product: items[i])
                : ProductCardWidget(product: Product.fakeList().first)
                .skeleton(true),
          );
        },
      ),
    );
  }
}