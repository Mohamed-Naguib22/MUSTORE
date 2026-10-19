abstract final class ProductEndpoints {
  static const String _prefix = 'Product';

  static String getCategoryProducts(String categoryId) => '$_prefix/GetCategoryProducts/$categoryId';
  static String getProductsBySellerId(String sellerId) => '$_prefix/GetProductsBySellerId/$sellerId';
  static String getById(String productId) => '$_prefix/GetById/$productId';
  static const String search = '$_prefix/Search';
  static const String autoComplete = '$_prefix/AutoComplete';
  static const String recentlyViewedProducts = '$_prefix/GetRecentlyViewedProducts';
  static const String previouslyOrdered = '$_prefix/GetPreviouslyOrdered';
  static const String newArrivals = '$_prefix/GetNewArrivals';
  static const String recommendedProducts = '$_prefix/GetRecommendedProducts';
  static const String productsOnSale = '$_prefix/GetProductsOnSale';
  static const String bestSellerProducts = '$_prefix/GetBestSellerProducts';
}