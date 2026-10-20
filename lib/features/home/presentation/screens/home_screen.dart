import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mustore/core/error/failure_message.dart';
import 'package:mustore/core/style/colors/app_colors.dart';
import 'package:mustore/core/style/dimens/dimens.dart';
import 'package:mustore/core/widgets/feedback/app_message_widget.dart';
import 'package:mustore/core/widgets/feedback/app_toast.dart';
import 'package:mustore/core/widgets/loading/app_skeleton.dart';
import 'package:mustore/features/auth/domain/enums/auth_status.dart';
import 'package:mustore/features/auth/presentation/controllers/auth_cubit.dart';
import 'package:mustore/features/catalog/domain/entities/category/category.dart';
import 'package:mustore/features/catalog/presentation/controllers/category/category_cubit.dart';
import 'package:mustore/features/catalog/presentation/controllers/category/category_state.dart';
import 'package:mustore/features/catalog/presentation/controllers/product/product_cubit.dart';
import 'package:mustore/features/catalog/presentation/controllers/product/product_state.dart';
import 'package:mustore/features/catalog/presentation/widgets/category/category_list_widget.dart';
import 'package:mustore/features/home/presentation/controllers/home_cubit.dart';
import 'package:mustore/features/home/presentation/widgets/banner_card_widget.dart';
import 'package:mustore/features/home/presentation/widgets/home_header_widget.dart';
import 'package:mustore/features/home/presentation/widgets/home_personal_section_widget.dart';
import 'package:mustore/features/home/presentation/widgets/home_search_field_widget.dart';
import 'package:mustore/features/home/presentation/widgets/home_section_header_widget.dart';
import 'package:mustore/features/home/presentation/widgets/home_section_widget.dart';
import 'package:mustore/features/home/presentation/widgets/promo_carousel_widget.dart';
import 'package:mustore/generated/l10n.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const _pageSize = 10;
  static const _categoriesTake = 7;

  late final ProductsCubit _productsCubit;
  late final CategoryCubit _categoryCubit;

  bool get _signedIn =>
      context.read<AuthCubit>().state.authStatus == AuthStatus.authenticated;

  @override
  void initState() {
    super.initState();
    _productsCubit = context.read<ProductsCubit>();
    _categoryCubit = context.read<CategoryCubit>();

    context.read<HomeCubit>().loadLocation();
    _categoryCubit.fetchRootCategories(_categoriesTake);
    _productsCubit
      ..fetchBestSeller(pageSize: _pageSize)
      ..fetchOnSale(pageSize: _pageSize)
      ..fetchRecommended(pageSize: _pageSize)
      ..fetchNewArrivals(pageSize: _pageSize);
  }

  Future<void> _refresh() => Future.wait([
    _categoryCubit.fetchRootCategories(_categoriesTake),
    _productsCubit.fetchBestSeller(pageSize: _pageSize),
    _productsCubit.fetchOnSale(pageSize: _pageSize),
    _productsCubit.fetchRecommended(pageSize: _pageSize),
    _productsCubit.fetchNewArrivals(pageSize: _pageSize),
    if (_signedIn) ...[
      _productsCubit.fetchPreviouslyOrdered(pageSize: _pageSize),
      _productsCubit.fetchRecentlyViewed(pageSize: _pageSize),
    ],
  ]);

  Widget _categoriesSection(S l10n, CategoryState state) {
    final items = state.rootCategories;
    final isLoading = state.status.isInitial || state.status.isLoading;

    final header = SliverToBoxAdapter(
      child: HomeSectionHeaderWidget(title: l10n.homeCategories),
    );

    if (state.status.isFailure && items.isEmpty) {
      final message = state.failure?.localizedMessage(context) ?? '';

      return SliverMainAxisGroup(
        slivers: [
          header,
          SliverToBoxAdapter(
            child: AppMessageWidget(
              message: message.isEmpty ? l10n.commonSomethingWentWrong : message,
              actionLabel: l10n.commonRetry,
              onAction: () => _categoryCubit.fetchRootCategories(_categoriesTake),
            ),
          ),
        ],
      );
    }

    if (items.isEmpty && !isLoading) {
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    }

    return AppSliverSkeleton(
      isLoading: isLoading,
      sliver: SliverMainAxisGroup(
        slivers: [
          header,
          SliverToBoxAdapter(
            child: CategoryListWidget(
              categories: items.isEmpty ? Category.fakeList(_categoriesTake) : items,
              onTap: (category) {},
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final scheme = Theme.of(context).colorScheme;

    final signedIn = context.select(
          (AuthCubit c) => c.state.authStatus == AuthStatus.authenticated,
    );

    return BlocListener<HomeCubit, HomeState>(
      listenWhen: (p, c) => p.failure != c.failure && c.failure != null,
      listener: (context, state) {
        final message = state.failure!.localizedMessage(context);

        if (message.isEmpty) return;

        AppToast.error(context, message);
      },
      child: Column(
        children: [
          const HomeHeaderWidget(),
          const HomeSearchFieldWidget(),
          Expanded(
            child: RefreshIndicator(
              color: scheme.primary,
              backgroundColor: scheme.surface,
              onRefresh: _refresh,
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: PromoCarouselWidget(banners: _banners(l10n)),
                  ),
                  BlocBuilder<CategoryCubit, CategoryState>(
                    bloc: _categoryCubit,
                    buildWhen: (p, c) =>
                    p.status != c.status ||
                        p.rootCategories != c.rootCategories,
                    builder: (context, state) =>
                        _categoriesSection(l10n, state),
                  ),
                  if (signedIn)
                    HomePersonalSectionWidget(
                      cubit: _productsCubit,
                      pageSize: _pageSize,
                    ),
                  BlocBuilder<ProductsCubit, ProductsState>(
                    bloc: _productsCubit,
                    buildWhen: (p, c) => p.bestSeller != c.bestSeller,
                    builder: (context, state) => HomeSectionWidget(
                      onSeeAll: () {},
                      title: l10n.homeBestSellers,
                      section: state.bestSeller,
                      onRetry: () => _productsCubit.fetchBestSeller(
                        pageSize: _pageSize,
                      ),
                    ),
                  ),
                  BlocBuilder<ProductsCubit, ProductsState>(
                    bloc: _productsCubit,
                    buildWhen: (p, c) => p.onSale != c.onSale,
                    builder: (context, state) => HomeSectionWidget(
                      onSeeAll: () {},
                      title: l10n.homeOnSale,
                      section: state.onSale,
                      onRetry: () => _productsCubit.fetchOnSale(
                        pageSize: _pageSize,
                      ),
                    ),
                  ),
                  BlocBuilder<ProductsCubit, ProductsState>(
                    bloc: _productsCubit,
                    buildWhen: (p, c) => p.recommended != c.recommended,
                    builder: (context, state) => HomeSectionWidget(
                      onSeeAll: () {},
                      title: l10n.homeRecommended,
                      section: state.recommended,
                      onRetry: () => _productsCubit.fetchRecommended(
                        pageSize: _pageSize,
                      ),
                    ),
                  ),
                  BlocBuilder<ProductsCubit, ProductsState>(
                    bloc: _productsCubit,
                    buildWhen: (p, c) => p.newArrivals != c.newArrivals,
                    builder: (context, state) => HomeSectionWidget(
                      onSeeAll: () {},
                      title: l10n.homeNewArrivals,
                      section: state.newArrivals,
                      onRetry: () => _productsCubit.fetchNewArrivals(
                        pageSize: _pageSize,
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(height: Dimens.xxl),
                  ),
                ],
              ),
            ),
          ),
        ],
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