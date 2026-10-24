import 'package:flutter/material.dart';
import 'package:mustore/features/catalog/presentation/controllers/product/product_cubit.dart';
import 'package:mustore/features/catalog/presentation/controllers/product/product_section.dart';
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
  State<HomePersonalSectionWidget> createState() =>
      _HomePersonalSectionWidgetState();
}

class _HomePersonalSectionWidgetState extends State<HomePersonalSectionWidget> {
  static const _sections = [
    ProductSection.previouslyOrdered,
    ProductSection.recentlyViewed,
  ];

  @override
  void initState() {
    super.initState();
    for (final s in _sections) {
      s.fetch(widget.cubit, pageSize: widget.pageSize);
    }
  }

  @override
  Widget build(BuildContext context) => SliverMainAxisGroup(
    slivers: [
      for (final s in _sections)
        HomeSectionWidget(
          cubit: widget.cubit,
          section: s,
          pageSize: widget.pageSize,
        ),
    ],
  );
}