import 'package:mustore/core/pagination/pagination_state.dart';
import 'package:mustore/features/catalog/domain/entities/product/product.dart';
import 'package:mustore/features/catalog/presentation/controllers/product/product_cubit.dart';
import 'package:mustore/features/catalog/presentation/controllers/product/product_state.dart';
import 'package:mustore/generated/l10n.dart';

enum ProductSection {
  recentlyViewed,
  previouslyOrdered,
  newArrivals,
  recommended,
  onSale,
  bestSeller;

  PaginationState<Product> of(ProductsState s) => switch (this) {
    recentlyViewed => s.recentlyViewed,
    previouslyOrdered => s.previouslyOrdered,
    newArrivals => s.newArrivals,
    recommended => s.recommended,
    onSale => s.onSale,
    bestSeller => s.bestSeller,
  };

  Future<void> fetch(ProductsCubit c, {bool loadMore = false, int? pageSize}) =>
      switch (this) {
        recentlyViewed => c.fetchRecentlyViewed(loadMore: loadMore, pageSize: pageSize),
        previouslyOrdered => c.fetchPreviouslyOrdered(loadMore: loadMore, pageSize: pageSize),
        newArrivals => c.fetchNewArrivals(loadMore: loadMore, pageSize: pageSize),
        recommended => c.fetchRecommended(loadMore: loadMore, pageSize: pageSize),
        onSale => c.fetchOnSale(loadMore: loadMore, pageSize: pageSize),
        bestSeller => c.fetchBestSeller(loadMore: loadMore, pageSize: pageSize),
      };

  String title(S l10n) => switch (this) {
    recentlyViewed => l10n.homeRecentlyViewed,
    previouslyOrdered => l10n.homePreviouslyOrdered,
    newArrivals => l10n.homeNewArrivals,
    recommended => l10n.homeRecommended,
    onSale => l10n.homeOnSale,
    bestSeller => l10n.homeBestSellers,
  };

  static ProductSection? parse(String? name) => values.asNameMap()[name];
}