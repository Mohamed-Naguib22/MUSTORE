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

    final imageUrl = url;

    Widget child = (imageUrl == null || imageUrl.isEmpty)
        ? placeholder
        : Stack(
      fit: StackFit.expand,
      children: [
        ColoredBox(color: bg),
        Image.network(
          imageUrl,
          fit: fit,
          frameBuilder: (_, image, frame, sync) => AnimatedOpacity(
            opacity: sync || frame != null ? 1 : 0,
            duration: Dimens.normal,
            curve: Curves.easeOut,
            child: image,
          ),
          errorBuilder: (_, __, ___) => placeholder,
        ),
      ],
    );

    if (borderRadius != null) {
      child = ClipRRect(borderRadius: borderRadius!, child: child);
    }

    if (width == null && height == null) return child;

    return SizedBox(width: width, height: height, child: child);
  }
}