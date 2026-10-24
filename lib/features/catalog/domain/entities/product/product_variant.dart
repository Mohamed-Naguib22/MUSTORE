import 'package:equatable/equatable.dart';
import 'package:mustore/features/catalog/domain/entities/product/product_color.dart';
import 'package:mustore/features/catalog/domain/entities/product/product_sale.dart';
import 'package:mustore/features/catalog/domain/enums/currency.dart';

class ProductVariant extends Equatable {
  final String id;
  final String? size;
  final ProductColor? color;
  final int stockQuantity;
  final CurrencyCode currency;
  final double price;
  final List<String> images;
  final ProductSale? sale;

  const ProductVariant({
    required this.id,
    this.size,
    this.color,
    required this.stockQuantity,
    required this.currency,
    required this.price,
    required this.images,
    this.sale,
  });

  const ProductVariant.fake({int index = 0})
      : id = 'placeholder_variant_$index',
        size = 'M',
        color = const ProductColor.fake(),
        stockQuantity = 10,
        currency = CurrencyCode.egp,
        price = 1000,
        images = const [''],
        sale = null;

  static List<ProductVariant> fakeList([int count = 2]) =>
      List.generate(count, (i) => ProductVariant.fake(index: i));

  ProductVariant copyWith({
    String? id,
    String? size,
    ProductColor? color,
    int? stockQuantity,
    CurrencyCode? currency,
    double? price,
    List<String>? images,
    ProductSale? sale,
  }) {
    return ProductVariant(
      id: id ?? this.id,
      size: size ?? this.size,
      color: color ?? this.color,
      stockQuantity: stockQuantity ?? this.stockQuantity,
      currency: currency ?? this.currency,
      price: price ?? this.price,
      images: images ?? this.images,
      sale: sale ?? this.sale,
    );
  }

  @override
  List<Object?> get props => [
    id,
    size,
    color,
    stockQuantity,
    currency,
    price,
    images,
    sale,
  ];
}