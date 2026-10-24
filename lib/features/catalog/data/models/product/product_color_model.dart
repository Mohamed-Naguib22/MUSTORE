import 'package:mustore/features/catalog/domain/entities/product/product_color.dart';

class ProductColorModel extends ProductColor {
  const ProductColorModel({
    required super.name,
    required super.hexaValue,
  });

  factory ProductColorModel.fromJson(Map<String, dynamic> json) {
    return ProductColorModel(
      name: json['name'] as String,
      hexaValue: json['hexaValue'] as String,
    );
  }
}