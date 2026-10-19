enum CurrencyCode { egp, usd, eur }

extension CurrencyCodeX on CurrencyCode {

  static CurrencyCode fromJson(String? value) {
    return CurrencyCode.values.firstWhere(
          (e) => e.name.toLowerCase() == value?.toLowerCase(),
      orElse: () => CurrencyCode.egp,
    );
  }
}