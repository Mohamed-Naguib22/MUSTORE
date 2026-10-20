import 'package:mustore/features/catalog/data/models/product/product_sale_model.dart';
import 'package:mustore/features/catalog/domain/entities/product/product.dart';
import 'package:mustore/features/catalog/domain/enums/currency.dart';

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

  static const _fallbackProductImages = [
    'https://images.unsplash.com/photo-1544947950-fa07a98d237f?w=600',
    'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=600',
    'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=600',
    'https://images.unsplash.com/photo-1526170375885-4d8ecf77b99f?w=600',
    'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=600',
    'https://images.unsplash.com/photo-1546435770-a3e426bf472b?w=600',
    'https://images.unsplash.com/photo-1585386959984-a4155224a1ad?w=600',
    'https://images.unsplash.com/photo-1572635196237-14b3f281503f?w=600',
  ];

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      price: (json['price'] as num).toDouble(),
      rating: (json['rating'] as num).toDouble(),
      numberOfReviews: (json['numberOfReviews'] as num).toDouble(),
      isAddedToWishlist: json['isAddedToWishlist'] as bool,
      currency: CurrencyCode.fromJson(json['currency'] as String?),
      // imageUrl: json['imageUrl'] as String,
      imageUrl: _fallbackProductImages[
      (json['id'] as String).hashCode.abs() %
          _fallbackProductImages.length
      ],
      sale: json['sale'] == null
          ? null
          : ProductSaleModel.fromJson(
        json['sale'] as Map<String, dynamic>,
      ),
    );
  }
}