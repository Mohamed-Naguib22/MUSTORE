import 'package:flutter/material.dart';
import 'package:mustore/core/pagination/pagination_state.dart';
import 'package:mustore/core/style/dimens/dimens.dart';
import 'package:mustore/core/widgets/loading/app_skeleton.dart';
import 'package:mustore/features/catalog/domain/entities/product/product.dart';
import 'package:mustore/features/catalog/presentation/widgets/product/product_card_widget.dart';
import 'package:mustore/features/catalog/presentation/widgets/product/products_row_widget.dart';
import 'package:mustore/features/home/presentation/widgets/home_section_header_widget.dart';

enum ProductsLayout { row, grid }

class HomeProductsSection extends StatelessWidget {
  const HomeProductsSection({
    super.key,
    required this.title,
    required this.section,
    this.layout = ProductsLayout.row,
    this.onSeeAll,
  });

  final String title;
  final PaginationState<Product> section;
  final ProductsLayout layout;
  final VoidCallback? onSeeAll;

  @override
  Widget build(BuildContext context) {
    final items = section.data.items;

    final isLoading = section.status == PaginationStatus.initial ||
        section.status == PaginationStatus.loading;

    if (items.isEmpty && !isLoading) {
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    }

    final products = items.isEmpty ? Product.fakeList() : items;

    return AppSliverSkeleton(
      isLoading: isLoading,
      sliver: SliverMainAxisGroup(
        slivers: [
          SliverToBoxAdapter(
            child: HomeSectionHeaderWidget(
              title: title,
              onSeeAll: isLoading ? null : onSeeAll,
            ),
          ),
          if (layout == ProductsLayout.row)
            SliverToBoxAdapter(
              child: ProductsRowWidget(products: products),
            )
          else
            SliverPadding(
              padding: const EdgeInsetsDirectional.fromSTEB(
                Dimens.lg,
                0,
                Dimens.lg,
                Dimens.xl,
              ),
              sliver: SliverGrid.builder(
                itemCount: products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: Dimens.md,
                  crossAxisSpacing: Dimens.md,
                  mainAxisExtent: kProductCardHeight,
                ),
                itemBuilder: (_, i) => ProductCardWidget(product: products[i]),
              ),
            ),
        ],
      ),
    );
  }
}