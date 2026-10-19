import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

class AppAsset extends StatelessWidget {
  const AppAsset(
      this.path, {
        super.key,
        this.width,
        this.height,
        this.color,
        this.fit = BoxFit.contain,
        this.semanticLabel,
        this.repeat = true,
        this.animate = true,
      });

  final String path;
  final double? width;
  final double? height;
  final Color? color;
  final BoxFit fit;
  final String? semanticLabel;
  final bool repeat;
  final bool animate;

  String get _ext => path.toLowerCase();
  bool get _isSvg => _ext.endsWith('.svg');
  bool get _isLottie => _ext.endsWith('.json') || _ext.endsWith('.lottie');

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

    if (_isLottie) {
      return Semantics(
        label: semanticLabel,
        image: true,
        child: Lottie.asset(
          path,
          width: width,
          height: height,
          fit: fit,
          repeat: repeat,
          animate: animate,
          delegates: color == null
              ? null
              : LottieDelegates(
            values: [
              ValueDelegate.colorFilter(
                const ['**'],
                value: ColorFilter.mode(color!, BlendMode.srcATop),
              ),
            ],
          ),
        ),
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