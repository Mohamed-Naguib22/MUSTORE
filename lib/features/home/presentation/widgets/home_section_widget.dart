import 'package:flutter/material.dart';
import 'package:mustore/core/error/failure_message.dart';
import 'package:mustore/core/pagination/pagination_state.dart';
import 'package:mustore/core/widgets/feedback/app_message_widget.dart';
import 'package:mustore/features/catalog/domain/entities/product/product.dart';
import 'package:mustore/generated/l10n.dart';
import 'home_products_section.dart';
import 'home_section_header_widget.dart';

class HomeSectionWidget extends StatelessWidget {
  const HomeSectionWidget({
    super.key,
    required this.title,
    required this.section,
    required this.onRetry,
    required this.onSeeAll,
  });

  final String title;
  final PaginationState<Product> section;
  final VoidCallback onRetry;
  final VoidCallback onSeeAll;

  @override
  Widget build(BuildContext context) {
    final failed = section.status == PaginationStatus.failure &&
        section.data.items.isEmpty;

    if (failed) {
      final message = section.failure?.localizedMessage(context) ?? '';

      return SliverMainAxisGroup(
        slivers: [
          SliverToBoxAdapter(
            child: HomeSectionHeaderWidget(title: title),
          ),
          SliverToBoxAdapter(
            child: AppMessageWidget(
              message: message.isEmpty
                  ? S.of(context).commonSomethingWentWrong
                  : message,
              actionLabel: S.of(context).commonRetry,
              onAction: onRetry,
            ),
          ),
        ],
      );
    }

    return HomeProductsSection(
      title: title,
      section: section,
      onSeeAll: onSeeAll,
    );
  }
}