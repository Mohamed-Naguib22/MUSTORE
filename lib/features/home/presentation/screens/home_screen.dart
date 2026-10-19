import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mustore/core/error/failure_message.dart';
import 'package:mustore/core/style/colors/app_colors.dart';
import 'package:mustore/core/widgets/feedback/app_toast.dart';
import 'package:mustore/features/catalog/presentation/controllers/product/product_cubit.dart';
import 'package:mustore/features/catalog/presentation/widgets/category/category_list_widget.dart';
import 'package:mustore/features/home/presentation/controllers/home_cubit.dart';
import 'package:mustore/features/home/presentation/widgets/banner_card_widget.dart';
import 'package:mustore/features/home/presentation/widgets/home_header_widget.dart';
import 'package:mustore/features/home/presentation/widgets/home_products_section.dart';
import 'package:mustore/features/home/presentation/widgets/home_search_field_widget.dart';
import 'package:mustore/features/home/presentation/widgets/home_section_header_widget.dart';
import 'package:mustore/features/home/presentation/widgets/promo_carousel_widget.dart';
import 'package:mustore/generated/l10n.dart';

class HomeCategory {
  const HomeCategory(this.name, this.icon);

  final String name;
  final IconData icon;
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().loadLocation();
    context.read<ProductsCubit>()
      ..fetchBestSeller()
      ..fetchOnSale()
      ..fetchRecommended()
      ..fetchNewArrivals();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);

    return BlocListener<HomeCubit, HomeState>(
      listenWhen: (p, c) => p.failure != c.failure && c.failure != null,
      listener: (context, state) {
        final message = state.failure!.localizedMessage(context);

        if (message.isEmpty) return;

        AppToast.error(context, message);
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              const HomeHeaderWidget(),
              const HomeSearchFieldWidget(),
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: PromoCarouselWidget(banners: _banners(l10n)),
                    ),
                    SliverToBoxAdapter(
                      child: HomeSectionHeaderWidget(title: l10n.homeCategories),
                    ),
                    SliverToBoxAdapter(
                      child: CategoryListWidget(categories: _categories(l10n)),
                    ),
                    HomeProductsSection(
                      title: l10n.homeBestSellers,
                      select: (s) => s.bestSeller,
                      onSeeAll: () {},
                    ),
                    HomeProductsSection(
                      title: l10n.homeOnSale,
                      select: (s) => s.onSale,
                      onSeeAll: () {},
                    ),
                    HomeProductsSection(
                      title: l10n.homeRecommended,
                      select: (s) => s.recommended,
                      onSeeAll: () {},
                    ),
                    HomeProductsSection(
                      title: l10n.homeNewArrivals,
                      select: (s) => s.newArrivals,
                      layout: ProductsLayout.grid,
                      onSeeAll: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
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