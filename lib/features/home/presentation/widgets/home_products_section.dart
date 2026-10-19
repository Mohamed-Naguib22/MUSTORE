import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mustore/core/pagination/pagination_state.dart';
import 'package:mustore/core/style/dimens/dimens.dart';
import 'package:mustore/core/widgets/loading/app_skeleton.dart';
import 'package:mustore/features/catalog/domain/entities/product/product.dart';
import 'package:mustore/features/catalog/domain/enums/currency.dart';
import 'package:mustore/features/catalog/presentation/controllers/product/product_cubit.dart';
import 'package:mustore/features/catalog/presentation/controllers/product/product_state.dart';
import 'package:mustore/features/catalog/presentation/widgets/product/product_card_widget.dart';
import 'package:mustore/features/catalog/presentation/widgets/product/products_row_widget.dart';
import 'package:mustore/features/home/presentation/widgets/home_section_header_widget.dart';

enum ProductsLayout { row, grid }

final List<Product> _placeholders = List.generate(
  6,
      (i) => Product(
    id: 'placeholder_$i',
    name: 'Product placeholder name',
    price: 1000,
    rating: 4.5,
    numberOfReviews: 0,
    isAddedToWishlist: false,
    currency: CurrencyCode.values.first,
    imageUrl: '',
  ),
);

class HomeProductsSection extends StatelessWidget {
  const HomeProductsSection({
    super.key,
    required this.title,
    required this.select,
    this.layout = ProductsLayout.row,
    this.onSeeAll,
  });

  final String title;
  final PaginationState<Product> Function(ProductsState state) select;
  final ProductsLayout layout;
  final VoidCallback? onSeeAll;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      buildWhen: (previous, current) => select(previous) != select(current),
      builder: (context, state) {
        final section = select(state);
        final items = section.data.items;

        final isLoading = items.isEmpty &&
            (section.status == PaginationStatus.initial ||
                section.status == PaginationStatus.loading);

        if (items.isEmpty && !isLoading) {
          return const SliverToBoxAdapter(child: SizedBox.shrink());
        }

        final products = isLoading ? _placeholders : items;

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
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: Dimens.md,
                      crossAxisSpacing: Dimens.md,
                      mainAxisExtent: kProductCardHeight,
                    ),
                    itemBuilder: (_, i) =>
                        ProductCardWidget(product: products[i]),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}