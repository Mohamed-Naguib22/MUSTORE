import 'package:mustore/features/catalog/domain/entities/category/category.dart';

class CategoryModel extends Category {
  const CategoryModel({
    required super.id,
    required super.name,
    required super.imageUrl,
  });

  static const _fallbackCategoryImages = [
    'https://images.unsplash.com/photo-1490481651871-ab68de25d43d?w=600',
    'https://images.unsplash.com/photo-1490312278390-ab64016e0aa9?w=600',
    'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=600',
    'https://images.unsplash.com/photo-1503602642458-232111445657?w=600',
    'https://images.unsplash.com/photo-1543163521-1bf539c55dd2?w=600',
    'https://images.unsplash.com/photo-1513519245088-0e12902e5a38?w=600',
  ];

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as String,
      name: json['name'] as String,
      // imageUrl: json['imageUrl'] as String,
      imageUrl: _fallbackCategoryImages[
      (json['id'] as String).hashCode.abs() %
          _fallbackCategoryImages.length
      ],
    );
  }
}