import 'package:equatable/equatable.dart';

class ProductReview extends Equatable {
  final String id;
  final String reviewerId;
  final String reviewer;
  final String reviewerImageUrl;
  final int rating;
  final String? comment;
  final String reviewDate;

  const ProductReview({
    required this.id,
    required this.reviewerId,
    required this.reviewer,
    required this.reviewerImageUrl,
    required this.rating,
    this.comment,
    required this.reviewDate,
  });

  const ProductReview.fake({int index = 0})
      : id = 'placeholder_review_$index',
        reviewerId = 'placeholder_reviewer',
        reviewer = 'Reviewer name',
        reviewerImageUrl = '',
        rating = 4,
        comment = 'Review placeholder comment text',
        reviewDate = '2026-01-01';

  static List<ProductReview> fakeList([int count = 3]) =>
      List.generate(count, (i) => ProductReview.fake(index: i));

  ProductReview copyWith({
    String? id,
    String? reviewerId,
    String? reviewer,
    String? reviewerImageUrl,
    int? rating,
    String? comment,
    String? reviewDate,
  }) {
    return ProductReview(
      id: id ?? this.id,
      reviewerId: reviewerId ?? this.reviewerId,
      reviewer: reviewer ?? this.reviewer,
      reviewerImageUrl: reviewerImageUrl ?? this.reviewerImageUrl,
      rating: rating ?? this.rating,
      comment: comment ?? this.comment,
      reviewDate: reviewDate ?? this.reviewDate,
    );
  }

  @override
  List<Object?> get props => [
    id,
    reviewerId,
    reviewer,
    reviewerImageUrl,
    rating,
    comment,
    reviewDate,
  ];
}