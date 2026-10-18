import 'package:flutter/material.dart';
import 'package:mustore/core/style/dimens/dimens.dart';
import 'package:mustore/core/style/colors/app_colors.dart';

class AppBottomSheet extends StatelessWidget {
  const AppBottomSheet({
    super.key,
    required this.child,
    this.title,
    this.footer,
    this.showHandle = true,
    this.showCloseButton = false,
    this.scrollable = true,
    this.maxHeightFactor = 0.9,
    this.padding = Dimens.screenH,
  });

  final Widget child;
  final String? title;
  final Widget? footer;
  final bool showHandle;
  final bool showCloseButton;
  final bool scrollable;
  final double maxHeightFactor;
  final EdgeInsetsGeometry padding;

  static Future<T?> show<T>(
      BuildContext context, {
        required Widget child,
        String? title,
        Widget? footer,
        bool showHandle = true,
        bool showCloseButton = false,
        bool scrollable = true,
        bool isDismissible = true,
        bool enableDrag = true,
        bool useRootNavigator = true,
        double maxHeightFactor = 0.9,
        EdgeInsetsGeometry padding = Dimens.screenH,
      }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      useRootNavigator: useRootNavigator,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      backgroundColor: AppColors.transparent,
      elevation: 0,
      builder: (_) => AppBottomSheet(
        title: title,
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

    final hasHeader = title != null || showCloseButton;

    final body = scrollable
        ? SingleChildScrollView(padding: padding, child: child)
        : Padding(padding: padding, child: child);

    return AnimatedPadding(
      duration: Dimens.fast,
      curve: Curves.easeOut,
      padding: EdgeInsets.only(bottom: keyboard),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: screenHeight * maxHeightFactor),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: s.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(Dimens.radiusXl)),
            boxShadow: [
              BoxShadow(
                color: s.shadow.withValues(alpha: 0.12),
                blurRadius: 24,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(Dimens.radiusXl)),
            child: SafeArea(
              top: false,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (showHandle)
                    Center(
                      child: Container(
                        width: Dimens.xxxl - Dimens.sm,
                        height: Dimens.xs,
                        margin: const EdgeInsetsDirectional.only(top: Dimens.md, bottom: Dimens.sm),
                        decoration: BoxDecoration(
                          color: s.outline.withValues(alpha: 0.6),
                          borderRadius: Dimens.borderPill,
                        ),
                      ),
                    )
                  else
                    Dimens.gapMd,
                  if (hasHeader)
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                        Dimens.lg,
                        Dimens.xs,
                        Dimens.sm,
                        Dimens.sm,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: title == null
                                ? const SizedBox.shrink()
                                : Text(
                              title!,
                              style: theme.textTheme.titleLarge,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (showCloseButton)
                            IconButton(
                              onPressed: () => Navigator.maybePop(context),
                              icon: const Icon(Icons.close_rounded),
                              color: s.onSurfaceVariant,
                              style: IconButton.styleFrom(
                                backgroundColor: s.surfaceContainerHighest,
                              ),
                            ),
                        ],
                      ),
                    ),
                  Flexible(child: body),
                  if (footer != null)
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                        Dimens.lg,
                        Dimens.md,
                        Dimens.lg,
                        Dimens.lg,
                      ),
                      child: footer,
                    )
                  else
                    Dimens.gapLg,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}