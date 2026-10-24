import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mustore/app/router/screens/not_found_screen.dart';
import 'package:mustore/core/error/failure_message.dart';
import 'package:mustore/core/pagination/pagination_state.dart';
import 'package:mustore/core/widgets/feedback/app_message_widget.dart';
import 'package:mustore/features/catalog/presentation/controllers/product/product_cubit.dart';
import 'package:mustore/features/catalog/presentation/controllers/product/product_section.dart';
import 'package:mustore/features/catalog/presentation/controllers/product/product_state.dart';
import 'package:mustore/features/catalog/presentation/widgets/product/products_grid_widget.dart';
import 'package:mustore/generated/l10n.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final _scroll = ScrollController();
  late final ProductsCubit _cubit;
  ProductSection? _section;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<ProductsCubit>();
    _scroll.addListener(_onScroll);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final section = ProductSection.parse(
      GoRouterState.of(context).pathParameters['section'],
    );

    if (section == null || section == _section) return;
    _section = section;
    section.fetch(_cubit);
  }

  void _onScroll() {
    final s = _section;
    if (s == null || !_scroll.hasClients) return;
    if (_scroll.position.extentAfter < 300) s.fetch(_cubit, loadMore: true);
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final section = _section;
    if (section == null) return const NotFoundScreen();
    final l10n = S.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(section.title(l10n))),
      body: BlocBuilder<ProductsCubit, ProductsState>(
        bloc: _cubit,
        buildWhen: (p, c) => section.of(p) != section.of(c),
        builder: (context, state) {
          final s = section.of(state);
          final items = s.data.items;

          if (s.status == PaginationStatus.failure && items.isEmpty) {
            return AppMessageWidget(
              message: s.failure?.localizedMessage(context) ?? l10n.commonSomethingWentWrong,
              actionLabel: l10n.commonRetry,
              onAction: () => section.fetch(_cubit),
            );
          }

          return RefreshIndicator(
            onRefresh: () => section.fetch(_cubit),
            child: ProductsGridWidget(
              controller: _scroll,
              products: items,
              isLoading: s.status == PaginationStatus.loading && items.isEmpty,
              loadingMore: s.status == PaginationStatus.loadingMore,
            ),
          );
        },
      ),
    );
  }
}