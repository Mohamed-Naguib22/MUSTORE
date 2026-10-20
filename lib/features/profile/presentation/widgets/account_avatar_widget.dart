import 'package:flutter/material.dart';
import 'package:mustore/core/style/dimens/dimens.dart';
import 'package:mustore/core/widgets/media/app_network_image.dart';

class AccountAvatarWidget extends StatelessWidget {
  const AccountAvatarWidget({super.key, required this.url, required this.name});

  final String? url;
  final String name;

  static const double _size = Dimens.xxxl + Dimens.sm;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final hasImage = url != null && url!.trim().isNotEmpty;

    if (hasImage) {
      return ClipOval(
        child: AppNetworkImage(url: url, width: _size, height: _size),
      );
    }

    final initial = name.isEmpty ? '?' : name.characters.first.toUpperCase();

    return Container(
      width: _size,
      height: _size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: scheme.primaryContainer,
        shape: BoxShape.circle,
      ),
      child: Text(
        initial,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          color: scheme.onPrimaryContainer,
        ),
      ),
    );
  }
}