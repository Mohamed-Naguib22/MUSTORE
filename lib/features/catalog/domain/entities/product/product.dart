import 'package:equatable/equatable.dart';
import 'package:mustore/features/catalog/domain/entities/product/product_sale.dart';
import 'package:mustore/features/catalog/domain/enums/currency.dart';

class Product extends Equatable {
  final String id;
  final String name;
  final String? description;
  final double price;
  final double rating;
  final double numberOfReviews;
  final bool isAddedToWishlist;
  final CurrencyCode currency;
  final String imageUrl;
  final ProductSale? sale;

  const Product({
    required this.id,
    required this.name,
    this.description,
    required this.price,
    required this.rating,
    required this.numberOfReviews,
    required this.isAddedToWishlist,
    required this.currency,
    required this.imageUrl,
    this.sale,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    price,
    rating,
    numberOfReviews,
    isAddedToWishlist,
    currency,
    imageUrl,
    sale,
  ];
}