enum SaleDiscountType { percentage, fixedAmount }

extension SaleDiscountTypeX on SaleDiscountType {

  static SaleDiscountType fromJson(String? value) {
    return SaleDiscountType.values.firstWhere(
          (e) => e.name.toLowerCase() == value?.toLowerCase(),
      orElse: () => SaleDiscountType.percentage,
    );
  }
}