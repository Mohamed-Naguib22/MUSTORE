import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mustore/core/pagination/paginated_list.dart';
import 'package:mustore/core/pagination/pagination_params.dart';
import 'package:mustore/core/pagination/pagination_state.dart';
import 'package:mustore/core/use_case/use_case.dart';
import 'package:mustore/core/utils/mixins/safe_emit_mixin.dart';
import 'package:mustore/features/catalog/domain/entities/product/product.dart';
import 'package:mustore/features/catalog/domain/use_cases/product/get_best_seller_products_use_case.dart';
import 'package:mustore/features/catalog/domain/use_cases/product/get_new_arrivals_use_case.dart';
import 'package:mustore/features/catalog/domain/use_cases/product/get_previously_ordered_use_case.dart';
import 'package:mustore/features/catalog/domain/use_cases/product/get_products_on_sale_use_case.dart';
import 'package:mustore/features/catalog/domain/use_cases/product/get_recently_viewed_products_use_case.dart';
import 'package:mustore/features/catalog/domain/use_cases/product/get_recommended_products_use_case.dart';
import 'package:mustore/features/catalog/presentation/controllers/product/product_state.dart';

class ProductsCubit extends Cubit<ProductsState>
    with SafeEmitMixin<ProductsState> {
  ProductsCubit({
    required GetRecentlyViewedProductsUseCase getRecentlyViewed,
    required GetPreviouslyOrderedUseCase getPreviouslyOrdered,
    required GetNewArrivalsUseCase getNewArrivals,
    required GetRecommendedProductsUseCase getRecommended,
    required GetProductsOnSaleUseCase getOnSale,
    required GetBestSellerProductsUseCase getBestSeller,
  })  : _getRecentlyViewed = getRecentlyViewed,
        _getPreviouslyOrdered = getPreviouslyOrdered,
        _getNewArrivals = getNewArrivals,
        _getRecommended = getRecommended,
        _getOnSale = getOnSale,
        _getBestSeller = getBestSeller,
        super(ProductsState());

  final GetRecentlyViewedProductsUseCase _getRecentlyViewed;
  final GetPreviouslyOrderedUseCase _getPreviouslyOrdered;
  final GetNewArrivalsUseCase _getNewArrivals;
  final GetRecommendedProductsUseCase _getRecommended;
  final GetProductsOnSaleUseCase _getOnSale;
  final GetBestSellerProductsUseCase _getBestSeller;

  Future<void> fetchRecentlyViewed({bool loadMore = false, int? pageSize}) => _fetch(
    current: state.recentlyViewed,
    useCase: _getRecentlyViewed,
    update: (s) => state.copyWith(recentlyViewed: s),
    loadMore: loadMore,
    pageSize: pageSize,
  );

  Future<void> fetchPreviouslyOrdered({bool loadMore = false, int? pageSize}) => _fetch(
    current: state.previouslyOrdered,
    useCase: _getPreviouslyOrdered,
    update: (s) => state.copyWith(previouslyOrdered: s),
    loadMore: loadMore,
    pageSize: pageSize,
  );

  Future<void> fetchNewArrivals({bool loadMore = false, int? pageSize}) => _fetch(
    current: state.newArrivals,
    useCase: _getNewArrivals,
    update: (s) => state.copyWith(newArrivals: s),
    loadMore: loadMore,
    pageSize: pageSize,
  );

  Future<void> fetchRecommended({bool loadMore = false, int? pageSize}) => _fetch(
    current: state.recommended,
    useCase: _getRecommended,
    update: (s) => state.copyWith(recommended: s),
    loadMore: loadMore,
    pageSize: pageSize,
  );

  Future<void> fetchOnSale({bool loadMore = false, int? pageSize}) => _fetch(
    current: state.onSale,
    useCase: _getOnSale,
    update: (s) => state.copyWith(onSale: s),
    loadMore: loadMore,
    pageSize: pageSize,
  );

  Future<void> fetchBestSeller({bool loadMore = false, int? pageSize}) => _fetch(
    current: state.bestSeller,
    useCase: _getBestSeller,
    update: (s) => state.copyWith(bestSeller: s),
    loadMore: loadMore,
    pageSize: pageSize,
  );

  Future<void> _fetch({
    required PaginationState<Product> current,
    required UseCase<PaginatedList<Product>, PaginationParams> useCase,
    required ProductsState Function(PaginationState<Product>) update,
    required bool loadMore,
    int? pageSize,
  }) async {
    if (current.isBusy) return;
    if (loadMore && !current.data.hasNextPage) return;

    safeEmit(update(current.copyWith(
      status: loadMore
          ? PaginationStatus.loadingMore
          : PaginationStatus.loading,
    )));

    final defaults = const PaginationParams();

    final result = await useCase(
      PaginationParams(
        pageNumber: loadMore ? current.data.nextPage : 1,
        pageSize: pageSize ?? defaults.pageSize,
      ),
    );

    safeFold(
      result,
      onLeft: (failure) => update(current.copyWith(
        status: PaginationStatus.failure,
        failure: failure,
      )),
      onRight: (page) => update(current.copyWith(
        status: PaginationStatus.success,
        data: loadMore ? current.data.appendPage(page) : page,
      )),
    );
  }
}