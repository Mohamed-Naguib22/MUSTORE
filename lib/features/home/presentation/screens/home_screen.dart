import 'package:flutter/material.dart';
import 'package:mustore/core/style/colors/app_colors.dart';
import 'package:mustore/core/style/dimens/dimens.dart';
import 'package:mustore/features/catalog/presentation/widgets/category/category_list_widget.dart';
import 'package:mustore/features/catalog/presentation/widgets/product/product_card_widget.dart';
import 'package:mustore/features/catalog/presentation/widgets/product/products_row_widget.dart';
import 'package:mustore/features/home/presentation/widgets/banner_card_widget.dart';
import 'package:mustore/features/home/presentation/widgets/home_header_widget.dart';
import 'package:mustore/features/home/presentation/widgets/home_search_field_widget.dart';
import 'package:mustore/features/home/presentation/widgets/home_section_header_widget.dart';
import 'package:mustore/features/home/presentation/widgets/promo_carousel_widget.dart';
import 'package:mustore/generated/l10n.dart';

class HomeCategory {
  const HomeCategory(this.name, this.icon);

  final String name;
  final IconData icon;
}

class HomeProduct {
  const HomeProduct({
    required this.name,
    required this.price,
    required this.rating,
    this.discountPercent,
    this.imageUrl,
  });

  final String name;
  final double price;
  final double rating;
  final int? discountPercent;
  final String? imageUrl;

  double get finalPrice =>
      discountPercent == null ? price : price * (100 - discountPercent!) / 100;
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: HomeHeaderWidget()),
            const SliverToBoxAdapter(child: HomeSearchFieldWidget()),
            SliverToBoxAdapter(child: PromoCarouselWidget(banners: _banners(l10n))),
            SliverToBoxAdapter(child: HomeSectionHeaderWidget(title: l10n.homeCategories)),
            SliverToBoxAdapter(child: CategoryListWidget(categories: _categories(l10n))),
            SliverToBoxAdapter(
              child: HomeSectionHeaderWidget(title: l10n.homeBestSellers, onSeeAll: () {}),
            ),
            const SliverToBoxAdapter(child: ProductsRowWidget(products: _products)),
            SliverToBoxAdapter(
              child: HomeSectionHeaderWidget(title: l10n.homeNewArrivals, onSeeAll: () {}),
            ),
            SliverPadding(
              padding: const EdgeInsetsDirectional.fromSTEB(
                Dimens.lg,
                0,
                Dimens.lg,
                Dimens.xl,
              ),
              sliver: SliverGrid.builder(
                itemCount: _products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: Dimens.md,
                  crossAxisSpacing: Dimens.md,
                  mainAxisExtent: kProductCardHeight,
                ),
                itemBuilder: (_, i) => ProductCardWidget(product: _products[i]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<HomeBanner> _banners(S l10n) => [
  HomeBanner(
    title: l10n.bannerSeasonSaleTitle,
    subtitle: l10n.bannerSeasonSaleSubtitle,
    icon: Icons.local_offer_rounded,
    colors: AppColors.bannerPrimary,
  ),
  HomeBanner(
    title: l10n.bannerNewArrivalsTitle,
    subtitle: l10n.bannerNewArrivalsSubtitle,
    icon: Icons.new_releases_rounded,
    colors: AppColors.bannerSecondary,
  ),
  HomeBanner(
    title: l10n.bannerFreeShippingTitle,
    subtitle: l10n.bannerFreeShippingSubtitle,
    icon: Icons.local_shipping_rounded,
    colors: AppColors.bannerSuccess,
  ),
];

List<HomeCategory> _categories(S l10n) => [
  HomeCategory(l10n.categoryFashion, Icons.checkroom_rounded),
  HomeCategory(l10n.categoryPhones, Icons.smartphone_rounded),
  HomeCategory(l10n.categoryLaptops, Icons.laptop_mac_rounded),
  HomeCategory(l10n.categoryHome, Icons.chair_rounded),
  HomeCategory(l10n.categoryBeauty, Icons.brush_rounded),
  HomeCategory(l10n.categorySports, Icons.sports_soccer_rounded),
  HomeCategory(l10n.categoryBooks, Icons.menu_book_rounded),
];

const _products = [
  HomeProduct(name: 'Wireless Headphones', price: 1200, rating: 4.7, discountPercent: 20),
  HomeProduct(name: 'Smart Watch Series 5', price: 3400, rating: 4.5),
  HomeProduct(name: 'Running Shoes', price: 1800, rating: 4.8, discountPercent: 35),
  HomeProduct(name: 'Leather Backpack', price: 950, rating: 4.3),
  HomeProduct(name: 'Mechanical Keyboard', price: 2100, rating: 4.9, discountPercent: 10),
  HomeProduct(name: 'Desk Lamp', price: 420, rating: 4.2),
];