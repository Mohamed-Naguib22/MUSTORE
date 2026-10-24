import 'package:mustore/features/catalog/data/models/product/product_sale_model.dart';
import 'package:mustore/features/catalog/domain/entities/product/product.dart';
import 'package:mustore/features/catalog/domain/enums/currency.dart';
import 'mock_images.dart';

class ProductModel extends Product {
  const ProductModel({
    required super.id,
    required super.name,
    super.description,
    required super.price,
    required super.rating,
    required super.numberOfReviews,
    required super.isAddedToWishlist,
    required super.currency,
    required super.imageUrl,
    super.sale,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    final id = json['id'] as String;
    return ProductModel(
      id: id,
      name: json['name'] as String,
      description: json['description'] as String?,
      price: (json['price'] as num).toDouble(),
      rating: (json['rating'] as num).toDouble(),
      numberOfReviews: (json['numberOfReviews'] as num).toDouble(),
      isAddedToWishlist: json['isAddedToWishlist'] as bool,
      currency: CurrencyCode.fromJson(json['currency'] as String?),
      // imageUrl: json['imageUrl'] as String,
      imageUrl: MockImages.product(id),
      sale: json['sale'] == null
          ? null
          : ProductSaleModel.fromJson(json['sale'] as Map<String, dynamic>),
    );
  }
}