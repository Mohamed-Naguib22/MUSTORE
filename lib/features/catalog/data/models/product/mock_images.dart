class MockImages {
  const MockImages._();

  static const _products = [
    'https://images.unsplash.com/photo-1544947950-fa07a98d237f?w=600',
    'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=600',
    'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=600',
    'https://images.unsplash.com/photo-1526170375885-4d8ecf77b99f?w=600',
    'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=600',
    'https://images.unsplash.com/photo-1546435770-a3e426bf472b?w=600',
    'https://images.unsplash.com/photo-1585386959984-a4155224a1ad?w=600',
    'https://images.unsplash.com/photo-1572635196237-14b3f281503f?w=600',
  ];

  static String product(String id) =>
      _products[id.hashCode.abs() % _products.length];

  static List<String> gallery(String id, {int count = 3}) {
    final start = id.hashCode.abs() % _products.length;
    return List.generate(
      count,
          (i) => _products[(start + i) % _products.length],
    );
  }

  static String avatar(String id) => 'https://i.pravatar.cc/150?u=$id';
}