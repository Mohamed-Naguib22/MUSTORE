import 'package:mustore/features/catalog/data/models/product/product_color_model.dart';
import 'package:mustore/features/catalog/data/models/product/product_sale_model.dart';
import 'package:mustore/features/catalog/domain/entities/product/product_variant.dart';
import 'package:mustore/features/catalog/domain/enums/currency.dart';
import 'mock_images.dart';

class ProductVariantModel extends ProductVariant {
  const ProductVariantModel({
    required super.id,
    super.size,
    super.color,
    required super.stockQuantity,
    required super.currency,
    required super.price,
    required super.images,
    super.sale,
  });

  factory ProductVariantModel.fromJson(Map<String, dynamic> json) {
    final id = json['id'] as String;
    return ProductVariantModel(
      id: id,
      size: json['size'] as String?,
      color: json['color'] == null
          ? null
          : ProductColorModel.fromJson(json['color'] as Map<String, dynamic>),
      stockQuantity: json['stockQuantity'] as int,
      currency: CurrencyCode.fromJson(json['currency'] as String?),
      price: (json['price'] as num).toDouble(),
      images: MockImages.gallery(id),
      sale: json['sale'] == null
          ? null
          : ProductSaleModel.fromJson(json['sale'] as Map<String, dynamic>),
    );
  }
}