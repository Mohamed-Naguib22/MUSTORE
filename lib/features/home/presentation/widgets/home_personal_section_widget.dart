import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mustore/features/catalog/presentation/controllers/product/product_cubit.dart';
import 'package:mustore/features/catalog/presentation/controllers/product/product_state.dart';
import 'package:mustore/generated/l10n.dart';
import 'home_section_widget.dart';

class HomePersonalSectionWidget extends StatefulWidget {
  const HomePersonalSectionWidget({
    super.key,
    required this.cubit,
    required this.pageSize,
  });

  final ProductsCubit cubit;
  final int pageSize;

  @override
  State<HomePersonalSectionWidget> createState() => _HomePersonalSectionWidgetState();
}

class _HomePersonalSectionWidgetState extends State<HomePersonalSectionWidget> {
  @override
  void initState() {
    super.initState();
    widget.cubit
      ..fetchPreviouslyOrdered(pageSize: widget.pageSize)
      ..fetchRecentlyViewed(pageSize: widget.pageSize);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final cubit = widget.cubit;

    return SliverMainAxisGroup(
      slivers: [
        BlocBuilder<ProductsCubit, ProductsState>(
          bloc: cubit,
          buildWhen: (p, c) => p.previouslyOrdered != c.previouslyOrdered,
          builder: (context, state) => HomeSectionWidget(
            onSeeAll: () {},
            title: l10n.homePreviouslyOrdered,
            section: state.previouslyOrdered,
            onRetry: () => cubit.fetchPreviouslyOrdered(
              pageSize: widget.pageSize,
            ),
          ),
        ),
        BlocBuilder<ProductsCubit, ProductsState>(
          bloc: cubit,
          buildWhen: (p, c) => p.recentlyViewed != c.recentlyViewed,
          builder: (context, state) => HomeSectionWidget(
            onSeeAll: () {},
            title: l10n.homeRecentlyViewed,
            section: state.recentlyViewed,
            onRetry: () => cubit.fetchRecentlyViewed(
              pageSize: widget.pageSize,
            ),
          ),
        ),
      ],
    );
  }
}
