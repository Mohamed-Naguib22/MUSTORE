import 'package:mustore/features/catalog/data/models/product/product_model.dart';
import 'package:mustore/features/catalog/data/models/product/product_review_model.dart';
import 'package:mustore/features/catalog/data/models/product/product_variant_model.dart';
import 'package:mustore/features/catalog/domain/entities/product/product_details.dart';

class ProductDetailsModel extends ProductDetails {
  const ProductDetailsModel({
    required super.id,
    required super.name,
    super.description,
    required super.rating,
    required super.numberOfReviews,
    required super.category,
    required super.categoryId,
    required super.seller,
    required super.isAddedToWishlist,
    required super.variants,
    required super.reviews,
    required super.relatedProducts,
  });

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailsModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      rating: (json['rating'] as num).toDouble(),
      numberOfReviews: (json['numberOfReviews'] as num).toDouble(),
      category: json['category'] as String,
      categoryId: json['categoryId'] as String,
      seller: json['seller'] as String,
      isAddedToWishlist: json['isAddedToWishlist'] as bool,
      variants: (json['productVariants'] as List? ?? const [])
          .map((e) => ProductVariantModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      reviews: (json['reviews'] as List? ?? const [])
          .map((e) => ProductReviewModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      relatedProducts: (json['relatedProducts'] as List? ?? const [])
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}