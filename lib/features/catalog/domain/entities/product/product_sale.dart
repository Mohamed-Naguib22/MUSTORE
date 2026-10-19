import 'package:equatable/equatable.dart';
import 'package:mustore/features/catalog/domain/enums/sale_discount_type.dart';

class ProductSale extends Equatable {
  final double priceAfterSale;
  final SaleDiscountType discountType;
  final double discountValue;

  const ProductSale({
    required this.priceAfterSale,
    required this.discountType,
    required this.discountValue,
  });

  @override
  List<Object?> get props => [priceAfterSale, discountType, discountValue];
}