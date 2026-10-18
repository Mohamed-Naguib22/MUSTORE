import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mustore/app/app_page.dart';
import 'package:mustore/core/style/colors/app_colors.dart';
import 'package:mustore/core/style/dimens/dimens.dart';
import 'package:mustore/core/widgets/buttons/app_button.dart';
import 'package:mustore/core/widgets/cards/app_card.dart';
import 'package:mustore/core/widgets/inputs/app_text_field.dart';
import 'package:mustore/features/auth/domain/enums/auth_status.dart';
import 'package:mustore/features/auth/presentation/controllers/auth_cubit.dart';
import 'package:mustore/generated/l10n.dart';

const double _productCardHeight = 270;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: _HomeHeader()),
            const SliverToBoxAdapter(child: _SearchField()),
            SliverToBoxAdapter(child: _PromoCarousel(banners: _banners(l10n))),
            SliverToBoxAdapter(child: _SectionHeader(title: l10n.homeCategories)),
            SliverToBoxAdapter(child: _CategoryList(categories: _categories(l10n))),
            SliverToBoxAdapter(
              child: _SectionHeader(title: l10n.homeBestSellers, onSeeAll: () {}),
            ),
            const SliverToBoxAdapter(child: _ProductsRow(products: _products)),
            SliverToBoxAdapter(
              child: _SectionHeader(title: l10n.homeNewArrivals, onSeeAll: () {}),
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
                  mainAxisExtent: _productCardHeight,
                ),
                itemBuilder: (_, i) => _ProductCard(product: _products[i]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ───────────────────────── Header ─────────────────────────

class _HomeHeader extends StatelessWidget {
  const _HomeHeader();

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    final l10n = S.of(context);
    final isGuest = context.select(
          (AuthCubit c) => c.state.authStatus != AuthStatus.authenticated,
    );

    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
        Dimens.lg,
        Dimens.md,
        Dimens.sm,
        Dimens.xs,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.homeWelcome,
                  style: text.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
                ),
                Text(
                  l10n.appTitle,
                  style: text.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: scheme.primary,
                  ),
                ),
              ],
            ),
          ),
          if (isGuest) ...[
            AppButton(
              label: l10n.authLogIn,
              variant: AppButtonVariant.tonal,
              expand: false,
              height: 36,
              onPressed: () => context.pushNamed(AppPage.login.name),
            ),
            Dimens.gapXs,
          ],
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.favorite_border_rounded),
          ),
          IconButton(
            onPressed: () {},
            icon: const Badge(
              label: Text('2'),
              child: Icon(Icons.shopping_bag_outlined),
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField();

  @override
  Widget build(BuildContext context) {
    // Read-only field that acts as a tap target for the search screen.
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
        Dimens.lg,
        Dimens.md,
        Dimens.lg,
        Dimens.lg,
      ),
      child: AppTextField(
        readOnly: true,
        hint: S.of(context).homeSearchHint,
        prefixIcon: Icons.search_rounded,
        suffixIcon: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.tune_rounded),
        ),
        onTap: () {},
      ),
    );
  }
}

// ───────────────────────── Promo carousel ─────────────────────────

class _PromoCarousel extends StatefulWidget {
  const _PromoCarousel({required this.banners});

  final List<_Banner> banners;

  @override
  State<_PromoCarousel> createState() => _PromoCarouselState();
}

class _PromoCarouselState extends State<_PromoCarousel> {
  final _controller = PageController(viewportFraction: 0.92);
  final _index = ValueNotifier<int>(0);

  @override
  void dispose() {
    _controller.dispose();
    _index.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        SizedBox(
          height: 160,
          child: PageView.builder(
            controller: _controller,
            itemCount: widget.banners.length,
            onPageChanged: (i) => _index.value = i,
            itemBuilder: (_, i) => Padding(
              padding: const EdgeInsetsDirectional.symmetric(horizontal: Dimens.xs),
              child: _BannerCard(banner: widget.banners[i]),
            ),
          ),
        ),
        Dimens.gapSm,
        ValueListenableBuilder<int>(
          valueListenable: _index,
          builder: (_, current, __) => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var i = 0; i < widget.banners.length; i++)
                AnimatedContainer(
                  duration: Dimens.normal,
                  margin: const EdgeInsetsDirectional.symmetric(horizontal: 3),
                  height: 6,
                  width: i == current ? 20 : 6,
                  decoration: BoxDecoration(
                    color: i == current ? scheme.primary : scheme.outline,
                    borderRadius: Dimens.borderPill,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _BannerCard extends StatelessWidget {
  const _BannerCard({required this.banner});

  final _Banner banner;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final l10n = S.of(context);

    return Container(
      padding: const EdgeInsetsDirectional.all(Dimens.lg + Dimens.xs),
      decoration: BoxDecoration(
        borderRadius: Dimens.borderXl,
        gradient: LinearGradient(
          begin: AlignmentDirectional.topStart,
          end: AlignmentDirectional.bottomEnd,
          colors: banner.colors,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  banner.title,
                  style: text.titleLarge?.copyWith(
                    color: AppColors.onBanner,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Dimens.gapXs,
                Text(
                  banner.subtitle,
                  style: text.bodyMedium?.copyWith(color: AppColors.onBannerMuted),
                ),
                Dimens.gapMd,
                AppButton(
                  label: l10n.homeShopNow,
                  expand: false,
                  height: 36,
                  backgroundColor: AppColors.onBanner,
                  foregroundColor: banner.colors.first,
                  onPressed: () {},
                ),
              ],
            ),
          ),
          Icon(banner.icon, size: Dimens.iconXl, color: AppColors.bannerIcon),
        ],
      ),
    );
  }
}

// ───────────────────────── Categories ─────────────────────────

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, this.onSeeAll});

  final String title;
  final VoidCallback? onSeeAll;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Dimens.section,
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          if (onSeeAll != null)
            TextButton(
              onPressed: onSeeAll,
              style: TextButton.styleFrom(
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: Dimens.sm,
                  vertical: Dimens.xs,
                ),
              ),
              child: Text(S.of(context).homeSeeAll),
            ),
        ],
      ),
    );
  }
}

class _CategoryList extends StatelessWidget {
  const _CategoryList({required this.categories});

  final List<_Category> categories;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return SizedBox(
      height: 92,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: Dimens.screenH,
        itemCount: categories.length,
        separatorBuilder: (_, __) => Dimens.gapLg,
        itemBuilder: (_, i) {
          final c = categories[i];
          return SizedBox(
            width: 68,
            child: Column(
              children: [
                AppCard(
                  variant: AppCardVariant.filled,
                  width: 60,
                  height: 60,
                  padding: EdgeInsets.zero,
                  onTap: () {},
                  child: Center(child: Icon(c.icon, color: scheme.primary)),
                ),
                Dimens.gapXs,
                Text(
                  c.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// ───────────────────────── Products ─────────────────────────

class _ProductsRow extends StatelessWidget {
  const _ProductsRow({required this.products});

  final List<_Product> products;

  @override
  Widget build(BuildContext context) {
    // A little room below the cards (+ Clip.none) so the shadow isn't cut off.
    return SizedBox(
      height: _productCardHeight + Dimens.xs + Dimens.md,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        padding: const EdgeInsetsDirectional.fromSTEB(
          Dimens.lg,
          Dimens.xs,
          Dimens.lg,
          Dimens.md,
        ),
        itemCount: products.length,
        separatorBuilder: (_, __) => Dimens.gapMd,
        itemBuilder: (_, i) => SizedBox(
          width: 170,
          child: _ProductCard(product: products[i]),
        ),
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  const _ProductCard({required this.product});

  final _Product product;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final l10n = S.of(context);

    return AppCard(
      padding: EdgeInsets.zero,
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                _ProductImage(url: product.imageUrl),
                if (product.discountPercent != null)
                  PositionedDirectional(
                    top: Dimens.sm,
                    start: Dimens.sm,
                    child: Container(
                      padding: const EdgeInsetsDirectional.symmetric(
                        horizontal: Dimens.sm,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: scheme.secondary,
                        borderRadius: Dimens.borderSm,
                      ),
                      child: Text(
                        '-${product.discountPercent}%',
                        style: text.labelSmall?.copyWith(
                          color: scheme.onSecondary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                PositionedDirectional(
                  top: Dimens.xs,
                  end: Dimens.xs,
                  child: IconButton.filled(
                    onPressed: () {},
                    visualDensity: VisualDensity.compact,
                    style: IconButton.styleFrom(
                      backgroundColor: scheme.surface.withValues(alpha: 0.92),
                      foregroundColor: scheme.onSurface,
                    ),
                    icon: const Icon(Icons.favorite_border_rounded, size: 18),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: Dimens.cardPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: text.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                ),
                Dimens.gapXs,
                Row(
                  children: [
                    const Icon(
                      Icons.star_rounded,
                      size: Dimens.iconSm,
                      color: AppColors.rating,
                    ),
                    Dimens.gapXxs,
                    Text(
                      product.rating.toStringAsFixed(1),
                      style: text.labelMedium,
                    ),
                  ],
                ),
                Dimens.gapXs,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      l10n.priceEgp(product.finalPrice.round()),
                      style: text.titleSmall?.copyWith(
                        color: scheme.primary,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    if (product.discountPercent != null) ...[
                      Dimens.gapSm,
                      Text(
                        product.price.toStringAsFixed(0),
                        style: text.labelSmall?.copyWith(
                          color: scheme.onSurfaceVariant,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductImage extends StatelessWidget {
  const _ProductImage({this.url});

  final String? url;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    final placeholder = ColoredBox(
      color: scheme.surfaceContainerHighest,
      child: Icon(
        Icons.image_outlined,
        size: Dimens.iconLg,
        color: scheme.onSurfaceVariant,
      ),
    );

    if (url == null) return placeholder;

    return Image.network(
      url!,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => placeholder,
      loadingBuilder: (_, child, progress) => progress == null ? child : placeholder,
    );
  }
}

// ───────────────────────── Temporary UI models + mock data ─────────────────────────
// Replace with your real models / Cubit state once the API is wired.

class _Banner {
  const _Banner(this.title, this.subtitle, this.icon, this.colors);

  final String title;
  final String subtitle;
  final IconData icon;
  final List<Color> colors;
}

class _Category {
  const _Category(this.name, this.icon);

  final String name;
  final IconData icon;
}

class _Product {
  const _Product({
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

List<_Banner> _banners(S l10n) => [
  _Banner(
    l10n.bannerSeasonSaleTitle,
    l10n.bannerSeasonSaleSubtitle,
    Icons.local_offer_rounded,
    AppColors.bannerPrimary,
  ),
  _Banner(
    l10n.bannerNewArrivalsTitle,
    l10n.bannerNewArrivalsSubtitle,
    Icons.new_releases_rounded,
    AppColors.bannerSecondary,
  ),
  _Banner(
    l10n.bannerFreeShippingTitle,
    l10n.bannerFreeShippingSubtitle,
    Icons.local_shipping_rounded,
    AppColors.bannerSuccess,
  ),
];

List<_Category> _categories(S l10n) => [
  _Category(l10n.categoryFashion, Icons.checkroom_rounded),
  _Category(l10n.categoryPhones, Icons.smartphone_rounded),
  _Category(l10n.categoryLaptops, Icons.laptop_mac_rounded),
  _Category(l10n.categoryHome, Icons.chair_rounded),
  _Category(l10n.categoryBeauty, Icons.brush_rounded),
  _Category(l10n.categorySports, Icons.sports_soccer_rounded),
  _Category(l10n.categoryBooks, Icons.menu_book_rounded),
];

const _products = [
  _Product(name: 'Wireless Headphones', price: 1200, rating: 4.7, discountPercent: 20),
  _Product(name: 'Smart Watch Series 5', price: 3400, rating: 4.5),
  _Product(name: 'Running Shoes', price: 1800, rating: 4.8, discountPercent: 35),
  _Product(name: 'Leather Backpack', price: 950, rating: 4.3),
  _Product(name: 'Mechanical Keyboard', price: 2100, rating: 4.9, discountPercent: 10),
  _Product(name: 'Desk Lamp', price: 420, rating: 4.2),
];