import 'package:flutter/material.dart';
import 'package:mustore/core/style/dimens/dimens.dart';

class AppListView extends StatelessWidget {
  const AppListView({
    super.key,
    required this.children,
    this.padding = Dimens.screen,
    this.controller,
    this.physics,
    this.shrinkWrap = false,
  });

  final List<Widget> children;
  final EdgeInsetsGeometry padding;
  final ScrollController? controller;
  final ScrollPhysics? physics;
  final bool shrinkWrap;

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: controller,
      physics: physics,
      shrinkWrap: shrinkWrap,
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      padding: padding,
      children: children,
    );
  }
}