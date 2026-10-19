import 'package:flutter/material.dart';
import 'package:mustore/core/style/dimens/dimens.dart';

class AppSwitch extends StatelessWidget {
  const AppSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.activeColor,
    this.activeThumb,
    this.inactiveThumb,
  });

  final bool value;
  final ValueChanged<bool>? onChanged;
  final Color? activeColor;

  final Widget? activeThumb;
  final Widget? inactiveThumb;

  static const _width = Dimens.xxxl + Dimens.xs;
  static const _height = Dimens.xxl;
  static const _pad = Dimens.xxs;
  static const _thumb = _height - 2 * _pad - 2;

  @override
  Widget build(BuildContext context) {
    final s = Theme.of(context).colorScheme;
    final enabled = onChanged != null;

    final track = value ? (activeColor ?? s.primary) : s.surfaceContainerHighest;
    final border = value ? (activeColor ?? s.primary) : s.outline;
    final thumb = value ? s.onPrimary : s.onSurfaceVariant;
    final content = value ? activeThumb : inactiveThumb;
    final thumbSize = (value || content != null) ? _thumb : _thumb - Dimens.xs;

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
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: content == null
                    ? null
                    : ClipOval(
                  child: AnimatedSwitcher(
                    duration: Dimens.fast,
                    child: SizedBox.expand(
                      key: ValueKey(value),
                      child: content,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}