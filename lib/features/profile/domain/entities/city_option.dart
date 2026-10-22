class CityOption {
  const CityOption({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.governorateEn,
    required this.governorateAr,
  });

  final String id;
  final String nameEn;
  final String nameAr;
  final String governorateEn;
  final String governorateAr;

  String name(bool isArabic) => isArabic ? nameAr : nameEn;
  String governorate(bool isArabic) => isArabic ? governorateAr : governorateEn;
  String label(bool isArabic) => '${name(isArabic)}, ${governorate(isArabic)}';

  bool matches(String cityName) => cityName == nameEn || cityName == nameAr;
}

/// TODO: replace with the cities API response.
const mockCities = <CityOption>[
  CityOption(
    id: '11111111-0000-0000-0000-000000000001',
    nameEn: '6th of October',
    nameAr: 'السادس من أكتوبر',
    governorateEn: 'Giza',
    governorateAr: 'الجيزة',
  ),
  CityOption(
    id: '11111111-0000-0000-0000-000000000002',
    nameEn: 'Sheikh Zayed',
    nameAr: 'الشيخ زايد',
    governorateEn: 'Giza',
    governorateAr: 'الجيزة',
  ),
  CityOption(
    id: '11111111-0000-0000-0000-000000000003',
    nameEn: 'Nasr City',
    nameAr: 'مدينة نصر',
    governorateEn: 'Cairo',
    governorateAr: 'القاهرة',
  ),
  CityOption(
    id: '11111111-0000-0000-0000-000000000004',
    nameEn: 'Maadi',
    nameAr: 'المعادي',
    governorateEn: 'Cairo',
    governorateAr: 'القاهرة',
  ),
  CityOption(
    id: '11111111-0000-0000-0000-000000000005',
    nameEn: 'New Cairo',
    nameAr: 'القاهرة الجديدة',
    governorateEn: 'Cairo',
    governorateAr: 'القاهرة',
  ),
  CityOption(
    id: '11111111-0000-0000-0000-000000000006',
    nameEn: 'Smouha',
    nameAr: 'سموحة',
    governorateEn: 'Alexandria',
    governorateAr: 'الإسكندرية',
  ),
];