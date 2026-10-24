import 'package:mustore/features/catalog/domain/entities/product/product_review.dart';
import 'mock_images.dart';

class ProductReviewModel extends ProductReview {
  const ProductReviewModel({
    required super.id,
    required super.reviewerId,
    required super.reviewer,
    required super.reviewerImageUrl,
    required super.rating,
    super.comment,
    required super.reviewDate,
  });

  factory ProductReviewModel.fromJson(Map<String, dynamic> json) {
    final reviewerId = json['reviewerId'] as String;
    return ProductReviewModel(
      id: json['id'] as String,
      reviewerId: reviewerId,
      reviewer: json['reviewer'] as String,
      // reviewerImageUrl: json['reviewerImageUrl'] as String,
      reviewerImageUrl: MockImages.avatar(reviewerId),
      rating: json['rating'] as int,
      comment: json['comment'] as String?,
      reviewDate: json['reviewDate'] as String,
    );
  }
}