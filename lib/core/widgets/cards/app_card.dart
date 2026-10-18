import 'package:flutter/material.dart';
import 'package:mustore/core/style/dimens/dimens.dart';
import 'package:mustore/core/style/colors/app_colors.dart';

enum AppCardVariant {
  elevated,
  filled,
  outlined,
}

class AppCard extends StatefulWidget {
  const AppCard({
    super.key,
    required this.child,
    this.onTap,
    this.onLongPress,
    this.variant = AppCardVariant.elevated,
    this.padding = Dimens.cardPadding,
    this.margin,
    this.borderRadius = Dimens.borderLg,
    this.color,
    this.width,
    this.height,
  });

  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final AppCardVariant variant;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadius borderRadius;
  final Color? color;

  final double? width;
  final double? height;

  @override
  State<AppCard> createState() => _AppCardState();
}

class _AppCardState extends State<AppCard> {
  bool _pressed = false;
  bool _hovered = false;

  bool get _interactive => widget.onTap != null || widget.onLongPress != null;

  List<BoxShadow> _shadows(ColorScheme s) {
    if (widget.variant != AppCardVariant.elevated) return const [];
    final (blur, dy, alpha) = _pressed
        ? (8.0, 2.0, 0.07)
        : _hovered
        ? (28.0, 12.0, 0.14)
        : (18.0, 6.0, 0.10);
    return [
      BoxShadow(
        color: s.shadow.withValues(alpha: 0.06),
        blurRadius: 3,
        offset: const Offset(0, 1),
      ),
      BoxShadow(
        color: s.shadow.withValues(alpha: alpha),
        blurRadius: blur,
        offset: Offset(0, dy),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final s = Theme.of(context).colorScheme;

    final fill = widget.color ??
        switch (widget.variant) {
          AppCardVariant.elevated => s.surface,
          AppCardVariant.filled => s.surfaceContainerHighest,
          AppCardVariant.outlined => AppColors.transparent,
        };

    final borderAlpha = switch (widget.variant) {
      AppCardVariant.outlined => 0.8,
      AppCardVariant.elevated => 0.55,
      AppCardVariant.filled => 0.3,
    };

    Widget content = Padding(padding: widget.padding, child: widget.child);

    if (_interactive) {
      content = InkWell(
        onTap: widget.onTap,
        onLongPress: widget.onLongPress,
        onHighlightChanged: (v) => setState(() => _pressed = v),
        onHover: (v) => setState(() => _hovered = v),
        splashColor: s.primary.withValues(alpha: 0.08),
        highlightColor: AppColors.transparent,
        hoverColor: s.primary.withValues(alpha: 0.04),
        child: content,
      );
    }

    final card = AnimatedContainer(
      duration: Dimens.fast,
      curve: Curves.easeOut,
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: fill,
        borderRadius: widget.borderRadius,
        border: Border.all(color: s.outline.withValues(alpha: borderAlpha)),
        boxShadow: _shadows(s),
      ),
      child: ClipRRect(
        borderRadius: widget.borderRadius,
        child: Material(type: MaterialType.transparency, child: content),
      ),
    );

    final scaled = _interactive
        ? AnimatedScale(
      scale: _pressed ? 0.98 : 1,
      duration: Dimens.fast,
      curve: Curves.easeOut,
      child: card,
    )
        : card;

    return widget.margin == null
        ? scaled
        : Padding(padding: widget.margin!, child: scaled);
  }
}