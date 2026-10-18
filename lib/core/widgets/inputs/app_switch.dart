import 'package:flutter/material.dart';
import 'package:mustore/core/style/dimens/dimens.dart';

class AppSwitch extends StatelessWidget {
  const AppSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.activeColor,
  });

  final bool value;
  final ValueChanged<bool>? onChanged;
  final Color? activeColor;

  static const _width = 48.0;
  static const _height = 28.0;
  static const _thumb = 22.0;
  static const _pad = 3.0;

  @override
  Widget build(BuildContext context) {
    final s = Theme.of(context).colorScheme;
    final enabled = onChanged != null;

    final track = value ? (activeColor ?? s.primary) : s.surfaceContainerHighest;
    final border = value ? (activeColor ?? s.primary) : s.outline;
    final thumb = value ? s.onPrimary : s.onSurfaceVariant;
    final thumbSize = value ? _thumb : _thumb - Dimens.xs;

    return Semantics(
      toggled: value,
      enabled: enabled,
      child: Opacity(
        opacity: enabled ? 1 : 0.5,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: enabled ? () => onChanged!(!value) : null,
          child: AnimatedContainer(
            duration: Dimens.fast,
            curve: Curves.easeOut,
            width: _width,
            height: _height,
            padding: const EdgeInsets.all(_pad),
            decoration: BoxDecoration(
              color: track,
              borderRadius: Dimens.borderPill,
              border: Border.all(color: border),
            ),
            child: AnimatedAlign(
              duration: Dimens.fast,
              curve: Curves.easeOut,
              alignment: value
                  ? AlignmentDirectional.centerEnd
                  : AlignmentDirectional.centerStart,
              child: AnimatedContainer(
                duration: Dimens.fast,
                curve: Curves.easeOut,
                width: thumbSize,
                height: thumbSize,
                decoration: BoxDecoration(
                  color: thumb,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: s.shadow.withValues(alpha: 0.2),
                      blurRadius: 3,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}