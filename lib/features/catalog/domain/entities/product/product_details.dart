import 'package:equatable/equatable.dart';
import 'package:mustore/features/catalog/domain/entities/product/product.dart';
import 'package:mustore/features/catalog/domain/entities/product/product_review.dart';
import 'package:mustore/features/catalog/domain/entities/product/product_variant.dart';

class ProductDetails extends Equatable {
  final String id;
  final String name;
  final String? description;
  final double rating;
  final double numberOfReviews;
  final String category;
  final String categoryId;
  final String seller;
  final bool isAddedToWishlist;
  final List<ProductVariant> variants;
  final List<ProductReview> reviews;
  final List<Product> relatedProducts;

  const ProductDetails({
    required this.id,
    required this.name,
    this.description,
    required this.rating,
    required this.numberOfReviews,
    required this.category,
    required this.categoryId,
    required this.seller,
    required this.isAddedToWishlist,
    required this.variants,
    required this.reviews,
    required this.relatedProducts,
  });

  factory ProductDetails.fake() => ProductDetails(
    id: 'placeholder',
    name: 'Product placeholder name',
    description: 'Product placeholder description text',
    rating: 4.5,
    numberOfReviews: 0,
    category: 'Category',
    categoryId: 'placeholder_category',
    seller: 'Seller',
    isAddedToWishlist: false,
    variants: ProductVariant.fakeList(2),
    reviews: ProductReview.fakeList(3),
    relatedProducts: Product.fakeList(4),
  );

  ProductDetails copyWith({
    String? id,
    String? name,
    String? description,
    double? rating,
    double? numberOfReviews,
    String? category,
    String? categoryId,
    String? seller,
    bool? isAddedToWishlist,
    List<ProductVariant>? variants,
    List<ProductReview>? reviews,
    List<Product>? relatedProducts,
  }) {
    return ProductDetails(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      rating: rating ?? this.rating,
      numberOfReviews: numberOfReviews ?? this.numberOfReviews,
      category: category ?? this.category,
      categoryId: categoryId ?? this.categoryId,
      seller: seller ?? this.seller,
      isAddedToWishlist: isAddedToWishlist ?? this.isAddedToWishlist,
      variants: variants ?? this.variants,
      reviews: reviews ?? this.reviews,
      relatedProducts: relatedProducts ?? this.relatedProducts,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    rating,
    numberOfReviews,
    category,
    categoryId,
    seller,
    isAddedToWishlist,
    variants,
    reviews,
    relatedProducts,
  ];
}