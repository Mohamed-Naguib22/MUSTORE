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

  const Product.fake({int index = 0})
      : id = 'placeholder_$index',
        name = 'Product placeholder name',
        description = null,
        price = 1000,
        rating = 4.5,
        numberOfReviews = 0,
        isAddedToWishlist = false,
        currency = CurrencyCode.egp,
        imageUrl = '',
        sale = null;

  static List<Product> fakeList([int count = 6]) =>
      List.generate(count, (i) => Product.fake(index: i));

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