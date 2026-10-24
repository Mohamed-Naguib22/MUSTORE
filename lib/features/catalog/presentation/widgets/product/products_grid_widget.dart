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

  static const _placeholders = 6;
  static const _moreCount = 2;

  @override
  Widget build(BuildContext context) {
    final items = isLoading ? Product.fakeList(_placeholders) : products;
    final extra = loadingMore ? _moreCount : 0;

    return AppSkeleton(
      isLoading: isLoading,
      child: GridView.builder(
        controller: controller,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsetsDirectional.fromSTEB(
          Dimens.lg,
          Dimens.xs,
          Dimens.lg,
          Dimens.md,
        ),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 180,
          mainAxisExtent: kProductCardHeight,
          mainAxisSpacing: Dimens.md,
          crossAxisSpacing: Dimens.md,
        ),
        itemCount: items.length + extra,
        itemBuilder: (_, i) => i < items.length
            ? ProductCardWidget(product: items[i])
            : ProductCardWidget(product: Product.fakeList(1).first)
            .skeleton(true),
      ),
    );
  }
}