import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mustore/app/app_page.dart';
import 'package:mustore/core/widgets/navigation/app_bottom_nav_bar.dart';
import 'package:mustore/generated/l10n.dart';

class MainShell extends StatelessWidget {
  const MainShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: navigationShell.currentIndex,
        onSelected: (i) => navigationShell.goBranch(
          i,
          initialLocation: i == navigationShell.currentIndex,
        ),
        items: [
          for (final t in AppPage.tabs)
            AppNavItem(
              icon: t.icon ?? Icons.circle_outlined,
              selectedIcon: t.selectedIcon ?? t.icon ?? Icons.circle,
              label: t.titleOf(l10n),
            ),
        ],
      ),
    );
  }
}