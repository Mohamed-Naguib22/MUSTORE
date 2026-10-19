import 'package:flutter/material.dart';
import 'package:mustore/core/style/colors/app_colors.dart';
import 'package:mustore/core/style/dimens/dimens.dart';
import 'package:toastification/toastification.dart';

abstract final class AppToast {
  static const Duration _defaultDuration = Duration(seconds: 4);

  static ToastificationItem success(
      BuildContext context,
      String message, {
        String? title,
        Duration? duration,
        Alignment alignment = Alignment.topCenter,
      }) =>
      _show(context, _ToastKind.success, message, title, duration, alignment);

  static ToastificationItem error(
      BuildContext context,
      String message, {
        String? title,
        Duration? duration,
        Alignment alignment = Alignment.topCenter,
      }) =>
      _show(context, _ToastKind.error, message, title, duration, alignment);

  static ToastificationItem warning(
      BuildContext context,
      String message, {
        String? title,
        Duration? duration,
        Alignment alignment = Alignment.topCenter,
      }) =>
      _show(context, _ToastKind.warning, message, title, duration, alignment);

  static ToastificationItem info(
      BuildContext context,
      String message, {
        String? title,
        Duration? duration,
        Alignment alignment = Alignment.topCenter,
      }) =>
      _show(context, _ToastKind.info, message, title, duration, alignment);

  static void dismissAll() => toastification.dismissAll();

  static ToastificationItem _show(
      BuildContext context,
      _ToastKind kind,
      String message,
      String? title,
      Duration? duration,
      Alignment alignment,
      ) {
    final theme = Theme.of(context);
    final s = theme.colorScheme;
    final text = theme.textTheme;

    final (accent, icon, type) = switch (kind) {
      _ToastKind.success => (
      s.tertiary,
      Icons.check_rounded,
      ToastificationType.success,
      ),
      _ToastKind.error => (
      s.error,
      Icons.close_rounded,
      ToastificationType.error,
      ),
      _ToastKind.warning => (
      AppColors.warning,
      Icons.priority_high_rounded,
      ToastificationType.warning,
      ),
      _ToastKind.info => (
      s.primary,
      Icons.info_outline_rounded,
      ToastificationType.info,
      ),
    };

    return toastification.show(
      context: context,
      type: type,
      style: ToastificationStyle.flat,
      alignment: alignment,
      autoCloseDuration: duration ?? _defaultDuration,
      animationDuration: Dimens.normal,
      direction: Directionality.of(context),
      title: Text(
        title ?? message,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        style: text.titleSmall?.copyWith(
          color: s.onSurface,
          fontWeight: FontWeight.w600,
        ),
      ),
      description: title == null
          ? null
          : Text(
        message,
        maxLines: 4,
        overflow: TextOverflow.ellipsis,
        style: text.bodyMedium?.copyWith(color: s.onSurfaceVariant),
      ),
      icon: Container(
        width: Dimens.iconLg,
        height: Dimens.iconLg,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: accent.withValues(alpha: 0.12),
          borderRadius: Dimens.borderSm,
        ),
        child: Icon(icon, size: Dimens.iconMd, color: accent),
      ),
      primaryColor: accent,
      backgroundColor: s.surface,
      foregroundColor: s.onSurface,
      borderRadius: Dimens.borderMd,
      borderSide: BorderSide(color: s.outlineVariant),
      margin: Dimens.screen,
      padding: const EdgeInsetsDirectional.all(Dimens.md),
      boxShadow: const [],
      showProgressBar: false,
    );
  }
}

enum _ToastKind { success, error, warning, info }