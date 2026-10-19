import 'package:flutter/material.dart';
import 'package:mustore/core/widgets/media/app_network_image.dart';

class ProductImageWidget extends StatelessWidget {
  const ProductImageWidget({super.key, this.url});

  final String? url;

  @override
  Widget build(BuildContext context) => AppNetworkImage(url: url);
}