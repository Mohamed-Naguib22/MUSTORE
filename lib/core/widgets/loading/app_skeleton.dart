import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AppSkeleton extends StatelessWidget {
  const AppSkeleton({
    super.key,
    required this.isLoading,
    required this.child,
    this.ignoreContainers = false,
    this.justifyMultiLineText = true,
    this.pulse = false,
  });

  final bool isLoading;
  final Widget child;
  final bool ignoreContainers;
  final bool justifyMultiLineText;
  final bool pulse;

  @override
  Widget build(BuildContext context) {
    final style = _SkeletonStyle.of(context, pulse: pulse);
    return Skeletonizer(
      enabled: isLoading,
      effect: style.effect,
      containersColor: style.containersColor,
      ignoreContainers: ignoreContainers,
      justifyMultiLineText: justifyMultiLineText,
      textBoneBorderRadius: TextBoneBorderRadius.fromHeightFactor(0.5),
      child: child,
    );
  }
}

class AppSliverSkeleton extends StatelessWidget {
  const AppSliverSkeleton({
    super.key,
    required this.isLoading,
    required this.sliver,
    this.ignoreContainers = false,
    this.justifyMultiLineText = true,
    this.pulse = false,
  });

  final bool isLoading;
  final Widget sliver;
  final bool ignoreContainers;
  final bool justifyMultiLineText;
  final bool pulse;

  @override
  Widget build(BuildContext context) {
    final style = _SkeletonStyle.of(context, pulse: pulse);
    return SliverSkeletonizer(
      enabled: isLoading,
      effect: style.effect,
      containersColor: style.containersColor,
      ignoreContainers: ignoreContainers,
      justifyMultiLineText: justifyMultiLineText,
      textBoneBorderRadius: TextBoneBorderRadius.fromHeightFactor(0.5),
      child: sliver,
    );
  }
}

extension AppSkeletonX on Widget {
  Widget skeleton(bool isLoading, {bool ignoreContainers = false}) => AppSkeleton(
    isLoading: isLoading,
    ignoreContainers: ignoreContainers,
    child: this,
  );
}

class _SkeletonStyle {
  const _SkeletonStyle(this.effect, this.containersColor);

  final PaintingEffect effect;
  final Color containersColor;

  factory _SkeletonStyle.of(BuildContext context, {required bool pulse}) {
    final s = Theme.of(context).colorScheme;

    final base = Color.alphaBlend(s.onSurface.withValues(alpha: 0.08), s.surface);
    final highlight = Color.alphaBlend(s.onSurface.withValues(alpha: 0.03), s.surface);

    final PaintingEffect effect = pulse
        ? PulseEffect(from: base, to: highlight, duration: const Duration(milliseconds: 900))
        : ShimmerEffect(
      baseColor: base,
      highlightColor: highlight,
      duration: const Duration(milliseconds: 1400),
    );

    return _SkeletonStyle(effect, base);
  }
}