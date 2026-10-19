import 'package:equatable/equatable.dart';
import 'package:mustore/core/pagination/pagination_state.dart';
import 'package:mustore/features/catalog/domain/entities/product/product.dart';

class ProductsState extends Equatable {
  ProductsState({
    PaginationState<Product>? recentlyViewed,
    PaginationState<Product>? previouslyOrdered,
    PaginationState<Product>? newArrivals,
    PaginationState<Product>? recommended,
    PaginationState<Product>? onSale,
  })  : recentlyViewed = recentlyViewed ?? PaginationState<Product>(),
        previouslyOrdered = previouslyOrdered ?? PaginationState<Product>(),
        newArrivals = newArrivals ?? PaginationState<Product>(),
        recommended = recommended ?? PaginationState<Product>(),
        onSale = onSale ?? PaginationState<Product>();

  final PaginationState<Product> recentlyViewed;
  final PaginationState<Product> previouslyOrdered;
  final PaginationState<Product> newArrivals;
  final PaginationState<Product> recommended;
  final PaginationState<Product> onSale;

  ProductsState copyWith({
    PaginationState<Product>? recentlyViewed,
    PaginationState<Product>? previouslyOrdered,
    PaginationState<Product>? newArrivals,
    PaginationState<Product>? recommended,
    PaginationState<Product>? onSale,
  }) =>
      ProductsState(
        recentlyViewed: recentlyViewed ?? this.recentlyViewed,
        previouslyOrdered: previouslyOrdered ?? this.previouslyOrdered,
        newArrivals: newArrivals ?? this.newArrivals,
        recommended: recommended ?? this.recommended,
        onSale: onSale ?? this.onSale,
      );

  @override
  List<Object?> get props =>
      [recentlyViewed, previouslyOrdered, newArrivals, recommended, onSale];
}