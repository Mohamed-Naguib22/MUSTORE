import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mustore/app/app_page.dart';
import 'package:mustore/core/error/failure_message.dart';
import 'package:mustore/core/pagination/pagination_state.dart';
import 'package:mustore/core/widgets/feedback/app_message_widget.dart';
import 'package:mustore/features/catalog/domain/entities/product/product.dart';
import 'package:mustore/features/catalog/presentation/controllers/product/product_cubit.dart';
import 'package:mustore/features/catalog/presentation/controllers/product/product_section.dart';
import 'package:mustore/features/catalog/presentation/controllers/product/product_state.dart';
import 'package:mustore/generated/l10n.dart';
import 'home_products_section.dart';
import 'home_section_header_widget.dart';

class HomeSectionWidget extends StatelessWidget {
  const HomeSectionWidget({
    super.key,
    required this.cubit,
    required this.section,
    required this.pageSize,
  });

  final ProductsCubit cubit;
  final ProductSection section;
  final int pageSize;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      bloc: cubit,
      buildWhen: (p, c) => section.of(p) != section.of(c),
      builder: (context, state) => _content(context, section.of(state)),
    );
  }

  Widget _content(BuildContext context, PaginationState<Product> data) {
    final l10n = S.of(context);
    final title = section.title(l10n);

    final failed =
        data.status == PaginationStatus.failure && data.data.items.isEmpty;

    if (failed) {
      final message = data.failure?.localizedMessage(context) ?? '';

      return SliverMainAxisGroup(
        slivers: [
          SliverToBoxAdapter(
            child: HomeSectionHeaderWidget(title: title),
          ),
          SliverToBoxAdapter(
            child: AppMessageWidget(
              message: message.isEmpty ? l10n.commonSomethingWentWrong : message,
              actionLabel: l10n.commonRetry,
              onAction: () => section.fetch(cubit, pageSize: pageSize),
            ),
          ),
        ],
      );
    }

    return HomeProductsSection(
      title: title,
      section: data,
      onSeeAll: () => context.pushNamed(
        AppPage.products.name,
        pathParameters: {'section': section.name},
      ),
    );
  }
}