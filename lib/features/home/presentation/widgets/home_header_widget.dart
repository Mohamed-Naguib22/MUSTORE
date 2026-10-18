import 'package:flutter/material.dart';
import 'package:mustore/core/style/dimens/dimens.dart';
import 'package:mustore/generated/l10n.dart';

class HomeHeaderWidget extends StatelessWidget {
  const HomeHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    final l10n = S.of(context);

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
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.favorite_border_rounded),
          ),
          IconButton(
            onPressed: () {},
            icon: const Badge(
              label: Text('2'),
              child: Icon(Icons.notifications_outlined),
            ),
          ),
        ],
      ),
    );
  }
}