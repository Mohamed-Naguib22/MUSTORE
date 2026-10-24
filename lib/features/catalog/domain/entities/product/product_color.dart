import 'package:equatable/equatable.dart';

class ProductColor extends Equatable {
  final String name;
  final String hexaValue;

  const ProductColor({
    required this.name,
    required this.hexaValue,
  });

  const ProductColor.fake()
      : name = 'Color',
        hexaValue = '#CCCCCC';

  ProductColor copyWith({
    String? name,
    String? hexaValue,
  }) {
    return ProductColor(
      name: name ?? this.name,
      hexaValue: hexaValue ?? this.hexaValue,
    );
  }

  @override
  List<Object?> get props => [name, hexaValue];
}