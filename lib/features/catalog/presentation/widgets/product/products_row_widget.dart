import 'package:flutter/material.dart';
import 'package:mustore/core/style/dimens/dimens.dart';
import 'package:mustore/features/catalog/presentation/widgets/product/product_card_widget.dart';
import 'package:mustore/features/home/presentation/screens/home_screen.dart';

class ProductsRowWidget extends StatelessWidget {
  const ProductsRowWidget({super.key, required this.products});

  final List<HomeProduct> products;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kProductCardHeight + Dimens.xs + Dimens.md,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        padding: const EdgeInsetsDirectional.fromSTEB(
          Dimens.lg,
          Dimens.xs,
          Dimens.lg,
          Dimens.md,
        ),
        itemCount: products.length,
        separatorBuilder: (_, __) => Dimens.gapMd,
        itemBuilder: (_, i) => SizedBox(
          width: 170,
          child: ProductCardWidget(product: products[i]),
        ),
      ),
    );
  }
}