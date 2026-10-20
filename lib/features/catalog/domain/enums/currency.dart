enum CurrencyCode {
  egp('EGP'),
  usd('USD');

  const CurrencyCode(this.value);
  final String value;

  static CurrencyCode fromJson(String? value) {
    if (value == null) return CurrencyCode.egp;
    return CurrencyCode.values.firstWhere(
          (e) => e.value.toLowerCase() == value.toLowerCase(),
      orElse: () => throw FormatException('Unknown CurrencyCode: $value'),
    );
  }
}