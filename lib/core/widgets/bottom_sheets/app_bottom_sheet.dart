import 'package:flutter/material.dart';
import 'package:mustore/core/style/dimens/dimens.dart';
import 'package:mustore/core/style/colors/app_colors.dart';
import 'package:mustore/core/widgets/icons/app_icon_badge.dart';

class AppBottomSheet extends StatelessWidget {
  const AppBottomSheet({
    super.key,
    required this.child,
    this.title,
    this.leading,
    this.icon,
    this.footer,
    this.showHandle = true,
    this.showCloseButton = false,
    this.scrollable = true,
    this.maxHeightFactor = Dimens.sheetMaxHeightFactor,
    this.padding = Dimens.screenH,
  });

  final Widget child;
  final String? title;
  final Widget? leading;
  final IconData? icon;
  final Widget? footer;
  final bool showHandle;
  final bool showCloseButton;
  final bool scrollable;
  final double maxHeightFactor;
  final EdgeInsetsGeometry padding;

  static const BorderRadius _sheetRadius = BorderRadius.vertical(
    top: Radius.circular(Dimens.radiusXl),
  );

  static Future<T?> show<T>(
      BuildContext context, {
        required Widget child,
        String? title,
        Widget? leading,
        IconData? icon,
        Widget? footer,
        bool showHandle = true,
        bool showCloseButton = false,
        bool scrollable = true,
        bool isDismissible = true,
        bool enableDrag = true,
        bool useRootNavigator = true,
        double maxHeightFactor = Dimens.sheetMaxHeightFactor,
        EdgeInsetsGeometry padding = Dimens.screenH,
      }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      useRootNavigator: useRootNavigator,
      isDismissible: isDismissible,
      showDragHandle: false,
      enableDrag: enableDrag,
      backgroundColor: AppColors.transparent,
      elevation: 0,
      builder: (_) => AppBottomSheet(
        title: title,
        leading: leading,
        icon: icon,
        footer: footer,
        showHandle: showHandle,
        showCloseButton: showCloseButton,
        scrollable: scrollable,
        maxHeightFactor: maxHeightFactor,
        padding: padding,
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final s = theme.colorScheme;
    final screenHeight = MediaQuery.sizeOf(context).height;
    final keyboard = MediaQuery.viewInsetsOf(context).bottom;

    final leadingWidget =
        leading ?? (icon != null ? AppIconBadge(icon: icon!) : null);

    final hasHeader =
        title != null || showCloseButton || leadingWidget != null;

    final body = scrollable
        ? SingleChildScrollView(padding: padding, child: child)
        : Padding(padding: padding, child: child);

    return AnimatedPadding(
      duration: Dimens.fast,
      curve: Curves.easeOut,
      padding: EdgeInsets.only(bottom: keyboard),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: screenHeight * maxHeightFactor),
        child: Material(
          color: s.surface,
          elevation: 0,
          shadowColor: AppColors.transparent,
          surfaceTintColor: AppColors.transparent,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: _sheetRadius,
            side: BorderSide(color: s.outlineVariant),
          ),
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (showHandle)
                  Center(
                    child: Container(
                      width: Dimens.handleWidth,
                      height: Dimens.xs,
                      margin: const EdgeInsetsDirectional.only(
                        top: Dimens.md,
                        bottom: Dimens.sm,
                      ),
                      decoration: BoxDecoration(
                        color: s.outline,
                        borderRadius: Dimens.borderPill,
                      ),
                    ),
                  )
                else
                  Dimens.gapMd,
                if (hasHeader) ...[
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                      Dimens.lg,
                      Dimens.xs,
                      Dimens.md,
                      Dimens.md,
                    ),
                    child: Row(
                      children: [
                        if (leadingWidget != null) ...[
                          leadingWidget,
                          Dimens.gapMd,
                        ],
                        Expanded(
                          child: title == null
                              ? const SizedBox.shrink()
                              : Text(
                            title!,
                            style: theme.textTheme.titleMedium,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (showCloseButton) ...[
                          Dimens.gapSm,
                          IconButton(
                            onPressed: () => Navigator.maybePop(context),
                            icon: const Icon(Icons.close_rounded),
                            iconSize: Dimens.iconMd - Dimens.xs,
                            color: s.onSurfaceVariant,
                            tooltip: MaterialLocalizations.of(
                              context,
                            ).closeButtonTooltip,
                            style: IconButton.styleFrom(
                              backgroundColor: s.surfaceContainerHighest,
                              shape: const RoundedRectangleBorder(
                                borderRadius: Dimens.borderMd,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const Divider(),
                ],
                hasHeader ? Dimens.gapMd : Dimens.gapLg,
                Flexible(child: body),
                if (footer != null) ...[
                  Dimens.gapMd,
                  const Divider(),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                      Dimens.lg,
                      Dimens.md,
                      Dimens.lg,
                      Dimens.lg,
                    ),
                    child: footer,
                  ),
                ] else
                  Dimens.gapLg,
              ],
            ),
          ),
        ),
      ),
    );
  }
}