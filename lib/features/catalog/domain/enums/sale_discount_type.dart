enum SaleDiscountType {
  percentage('Percentage'),
  fixedAmount('FixedAmount');

  const SaleDiscountType(this.value);
  final String value;

  static SaleDiscountType fromJson(String? value) {
    if (value == null) return SaleDiscountType.percentage;
    return SaleDiscountType.values.firstWhere(
          (e) => e.value.toLowerCase() == value.toLowerCase(),
      orElse: () => throw FormatException('Unknown SaleDiscountType: $value'),
    );
  }
}