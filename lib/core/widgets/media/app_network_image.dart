import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mustore/core/style/dimens/dimens.dart';

class AppNetworkImage extends StatelessWidget {
  const AppNetworkImage({
    super.key,
    this.url,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.borderRadius,
    this.fallbackIcon = Icons.image_outlined,
    this.iconSize = Dimens.iconLg,
    this.iconColor,
    this.backgroundColor,
  });

  final String? url;
  final BoxFit fit;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final IconData fallbackIcon;
  final double iconSize;
  final Color? iconColor;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final bg = backgroundColor ?? scheme.surfaceContainerHighest;

    final placeholder = ColoredBox(
      color: bg,
      child: Center(
        child: Icon(
          fallbackIcon,
          size: iconSize,
          color: iconColor ?? scheme.onSurfaceVariant,
        ),
      ),
    );

    final imageUrl = url?.trim();

    Widget child;
    if (imageUrl == null || imageUrl.isEmpty) {
      child = placeholder;
    } else {
      child = LayoutBuilder(
        builder: (context, constraints) {
          final dpr = MediaQuery.devicePixelRatioOf(context);
          final w = width ??
              (constraints.hasBoundedWidth ? constraints.maxWidth : null);
          final h = height ??
              (constraints.hasBoundedHeight ? constraints.maxHeight : null);

          return CachedNetworkImage(
            imageUrl: imageUrl,
            fit: fit,
            width: double.infinity,
            height: double.infinity,
            memCacheWidth: w != null && w.isFinite ? (w * dpr).round() : null,
            memCacheHeight: (w == null && h != null && h.isFinite)
                ? (h * dpr).round()
                : null,
            fadeInDuration: Dimens.normal,
            fadeOutDuration: Dimens.normal,
            fadeInCurve: Curves.easeOut,
            placeholder: (_, _) => _ImagePulse(
              base: bg,
              highlight: scheme.surfaceBright,
            ),
            errorWidget: (_, _, _) => placeholder,
          );
        },
      );
    }

    if (borderRadius != null) {
      child = ClipRRect(borderRadius: borderRadius!, child: child);
    }

    if (width == null && height == null) return child;

    return SizedBox(width: width, height: height, child: child);
  }
}

class _ImagePulse extends StatefulWidget {
  const _ImagePulse({required this.base, required this.highlight});

  final Color base;
  final Color highlight;

  @override
  State<_ImagePulse> createState() => _ImagePulseState();
}

class _ImagePulseState extends State<_ImagePulse>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _c,
      builder: (_, _) => ColoredBox(
        color: Color.lerp(
          widget.base,
          widget.highlight,
          Curves.easeInOut.transform(_c.value),
        )!,
        child: const SizedBox.expand(),
      ),
    );
  }
}