import 'package:flutter/material.dart';
import 'package:mustore/core/widgets/appbar/custom_appbar_widget.dart';
import 'package:mustore/generated/l10n.dart';
import 'app_page.dart';

class AppPageScaffold extends StatelessWidget {
  const AppPageScaffold({
    super.key,
    required this.page,
    required this.child,
    this.safeArea = true,
    this.titleBuilder,
  });

  final AppPage page;
  final Widget child;
  final bool safeArea;
  final String Function(S l10n)? titleBuilder;

  @override
  Widget build(BuildContext context) {
    if (page.appBar == AppBarMode.none) {
      return Scaffold(
        body: safeArea ? SafeArea(child: child) : child,
      );
    }

    final l10n = S.of(context);

    return Scaffold(
      appBar: CustomAppbarWidget(
        title: titleBuilder?.call(l10n) ?? page.titleOf(l10n),
      ),
      body: child,
    );
  }
}