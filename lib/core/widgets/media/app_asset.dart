import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppAsset extends StatelessWidget {
  const AppAsset(
      this.path, {
        super.key,
        this.width,
        this.height,
        this.color,
        this.fit = BoxFit.contain,
        this.semanticLabel,
      });

  final String path;
  final double? width;
  final double? height;
  final Color? color;
  final BoxFit fit;
  final String? semanticLabel;

  bool get _isSvg => path.toLowerCase().endsWith('.svg');

  @override
  Widget build(BuildContext context) {
    if (_isSvg) {
      return SvgPicture.asset(
        path,
        width: width,
        height: height,
        fit: fit,
        semanticsLabel: semanticLabel,
        colorFilter:
        color == null ? null : ColorFilter.mode(color!, BlendMode.srcIn),
      );
    }

    return Image.asset(
      path,
      width: width,
      height: height,
      fit: fit,
      color: color,
      semanticLabel: semanticLabel,
    );
  }
}