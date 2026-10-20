import 'package:flutter/material.dart';
import 'package:mustore/core/style/dimens/dimens.dart';

class AppDivider extends StatelessWidget {
  const AppDivider({
    super.key,
    this.indent = 0,
    this.endIndent = 0,
    this.thickness = 1,
    this.color,
  });

  const AppDivider.listTile({super.key, this.color})
      : indent = Dimens.listTileInset,
        endIndent = 0,
        thickness = 1;

  final double indent;
  final double endIndent;
  final double thickness;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final line = ColoredBox(
      color: color ?? Theme.of(context).colorScheme.outlineVariant,
      child: SizedBox(height: thickness, width: double.infinity),
    );

    if (indent == 0 && endIndent == 0) return line;

    return Padding(
      padding: EdgeInsetsDirectional.only(start: indent, end: endIndent),
      child: line,
    );
  }
}