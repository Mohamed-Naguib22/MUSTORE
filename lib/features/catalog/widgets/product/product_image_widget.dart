import 'package:flutter/material.dart';
import 'package:mustore/core/style/dimens/dimens.dart';

class ProductImageWidget extends StatelessWidget {
  const ProductImageWidget({super.key, this.url});

  final String? url;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    final placeholder = ColoredBox(
      color: scheme.surfaceContainerHighest,
      child: Icon(
        Icons.image_outlined,
        size: Dimens.iconLg,
        color: scheme.onSurfaceVariant,
      ),
    );

    if (url == null) return placeholder;

    return Image.network(
      url!,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => placeholder,
      loadingBuilder: (_, child, progress) => progress == null ? child : placeholder,
    );
  }
}