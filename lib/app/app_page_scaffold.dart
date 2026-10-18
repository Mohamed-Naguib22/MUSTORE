import 'package:flutter/material.dart';
import 'package:mustore/core/widgets/appbar/custom_appbar_widget.dart';
import 'package:mustore/generated/l10n.dart';
import 'app_page.dart';

class AppPageScaffold extends StatelessWidget {
  const AppPageScaffold({super.key, required this.page, required this.child});

  final AppPage page;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (page.appBar == AppBarMode.none) return child;

    return Scaffold(
      appBar: CustomAppbarWidget(title: page.titleOf(S.of(context))),
      body: child,
    );
  }
}