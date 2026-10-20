import 'package:flutter/material.dart';
import 'package:mustore/core/style/dimens/dimens.dart';

class AppSegment<T> {
  const AppSegment({required this.value, required this.label});

  final T value;
  final String label;
}

class AppSegmentedSwitch<T> extends StatelessWidget {
  const AppSegmentedSwitch({
    super.key,
    required this.segments,
    required this.value,
    required this.onChanged,
    this.segmentWidth = _segmentWidth,
  }) : assert(segments.length >= 2);

  final List<AppSegment<T>> segments;
  final T value;
  final ValueChanged<T>? onChanged;
  final double segmentWidth;

  static const _segmentWidth = Dimens.xxxl + Dimens.xl;
  static const _height = Dimens.xxl;
  static const _pad = Dimens.xxs;

  @override
  Widget build(BuildContext context) {
    final s = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final enabled = onChanged != null;

    final count = segments.length;
    final index = segments.indexWhere((e) => e.value == value);
    final x = index < 0 ? -1.0 : -1 + 2 * index / (count - 1);

    return Opacity(
      opacity: enabled ? 1 : 0.5,
      child: Container(
        width: segmentWidth * count + 2 * _pad + 2,
        height: _height,
        padding: const EdgeInsets.all(_pad),
        decoration: BoxDecoration(
          color: s.surfaceContainerHighest,
          borderRadius: Dimens.borderPill,
          border: Border.all(color: s.outline),
        ),
        child: Stack(
          children: [
            if (index >= 0)
              AnimatedAlign(
                duration: Dimens.fast,
                curve: Curves.easeOut,
                alignment: AlignmentDirectional(x, 0),
                child: FractionallySizedBox(
                  widthFactor: 1 / count,
                  heightFactor: 1,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: s.primary,
                      borderRadius: Dimens.borderPill,
                      boxShadow: [
                        BoxShadow(
                          color: s.shadow.withValues(alpha: 0.2),
                          blurRadius: Dimens.xs,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            Row(
              children: [
                for (final segment in segments)
                  Expanded(
                    child: Semantics(
                      button: true,
                      selected: segment.value == value,
                      enabled: enabled,
                      label: segment.label,
                      excludeSemantics: true,
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: enabled && segment.value != value
                            ? () => onChanged!(segment.value)
                            : null,
                        child: Center(
                          child: AnimatedDefaultTextStyle(
                            duration: Dimens.fast,
                            curve: Curves.easeOut,
                            style: text.labelMedium!.copyWith(
                              fontWeight: FontWeight.w600,
                              color: segment.value == value
                                  ? s.onPrimary
                                  : s.onSurfaceVariant,
                            ),
                            child: Text(
                              segment.label,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}