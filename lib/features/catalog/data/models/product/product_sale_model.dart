import 'package:mustore/features/catalog/domain/entities/product/product_sale.dart';
import 'package:mustore/features/catalog/domain/enums/sale_discount_type.dart';

class ProductSaleModel extends ProductSale {
  const ProductSaleModel({
    required super.priceAfterSale,
    required super.discountType,
    required super.discountValue,
  });

  factory ProductSaleModel.fromJson(Map<String, dynamic> json) {
    return ProductSaleModel(
      priceAfterSale: (json['priceAfterSale'] as num).toDouble(),
      discountType: SaleDiscountType.fromJson(json['discountType'] as String?),
      discountValue: (json['discountValue'] as num).toDouble(),
    );
  }
}