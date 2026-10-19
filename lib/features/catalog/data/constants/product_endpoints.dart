abstract final class ProductEndpoints {
  static String getCategoryProducts(String categoryId) => 'GetCategoryProducts/$categoryId';
  static String getProductsBySellerId(String sellerId) => 'GetProductsBySellerId/$sellerId';
  static String getById(String productId) => 'GetById/$productId';
  static const String search = 'Search';
  static const String autoComplete = 'AutoComplete';
  static const String recentlyViewedProducts = 'GetRecentlyViewedProducts';
  static const String previouslyOrdered = 'GetPreviouslyOrdered';
  static const String newArrivals = 'GetNewArrivals';
  static const String recommendedProducts = 'GetRecommendedProducts';
  static const String productsOnSale = 'GetProductsOnSale';
}