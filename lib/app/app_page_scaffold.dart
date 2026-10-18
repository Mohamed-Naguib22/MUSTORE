import 'package:flutter/material.dart';
import 'package:mustore/core/widgets/custom_appbar_widget.dart';
import 'app_page.dart';

class AppPageScaffold extends StatelessWidget {
  const AppPageScaffold({super.key, required this.page, required this.child});

  final AppPage page;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (page.appBar == AppBarMode.none) return child;

    return Scaffold(
      appBar: CustomAppbarWidget(title: page.title),
      body: child,
    );
  }
}