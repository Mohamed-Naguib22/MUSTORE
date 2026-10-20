import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mustore/core/style/colors/app_colors.dart';
import 'package:mustore/core/style/dimens/dimens.dart';

class CustomAppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? titleWidget;
  final Widget? leading;
  final bool automaticallyImplyLeading;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;
  final bool centerTitle;
  final Color? backgroundColor;
  final double elevation;
  final BorderRadiusGeometry? borderRadius;
  final bool showDivider;

  const CustomAppbarWidget({
    super.key,
    this.title,
    this.titleWidget,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.actions,
    this.bottom,
    this.centerTitle = true,
    this.backgroundColor,
    this.elevation = 0,
    this.borderRadius,
    this.showDivider = true,
  }) : assert(
  title == null || titleWidget == null,
  'Provide either title or titleWidget, not both.',
  );

  static const double _sideWidth = Dimens.lg + Dimens.badge;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isDark = scheme.brightness == Brightness.dark;

    final borderSide = BorderSide(
      color: showDivider ? scheme.outlineVariant : AppColors.transparent,
    );

    final ShapeBorder shape = borderRadius != null
        ? RoundedRectangleBorder(borderRadius: borderRadius!, side: borderSide)
        : Border(bottom: borderSide);

    final canPop = Navigator.of(context).canPop();
    final Widget? effectiveLeading = leading ??
        (automaticallyImplyLeading && canPop
            ? const _BackAction()
            : null);

    final hasActions = actions != null && actions!.isNotEmpty;

    return AppBar(
      toolbarHeight: Dimens.appBarHeight,
      elevation: elevation,
      scrolledUnderElevation: 0,
      surfaceTintColor: AppColors.transparent,
      backgroundColor: backgroundColor ?? theme.scaffoldBackgroundColor,
      foregroundColor: scheme.onSurface,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: AppColors.transparent,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
      ),
      automaticallyImplyLeading: false,
      leadingWidth: effectiveLeading == null ? 0 : _sideWidth,
      leading: effectiveLeading == null
          ? null
          : Padding(
        padding: const EdgeInsetsDirectional.only(start: Dimens.lg),
        child: Align(
          alignment: AlignmentDirectional.centerStart,
          child: effectiveLeading,
        ),
      ),
      title: titleWidget ??
          (title == null
              ? null
              : Text(
            title!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.titleMedium,
          )),
      centerTitle: centerTitle,
      titleSpacing: Dimens.lg,
      actions: hasActions
          ? [
        for (var i = 0; i < actions!.length; i++) ...[
          if (i > 0) Dimens.gapXs,
          actions![i],
        ],
        const SizedBox(width: Dimens.lg),
      ]
          : null,
      bottom: bottom,
      shape: shape,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
    Dimens.appBarHeight + (bottom?.preferredSize.height ?? 0),
  );
}

class _BackAction extends StatelessWidget {
  const _BackAction();

  @override
  Widget build(BuildContext context) {
    return _AppbarButton(
      icon: Icons.arrow_back_ios_new_rounded,
      tooltip: MaterialLocalizations.of(context).backButtonTooltip,
      onPressed: () => Navigator.of(context).maybePop(),
    );
  }
}

class CustomAppbarAction extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final int count;
  final String? tooltip;

  const CustomAppbarAction({
    super.key,
    required this.icon,
    this.onPressed,
    this.count = 0,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return _AppbarButton(
      tooltip: tooltip,
      onPressed: onPressed,
      icon: icon,
      badgeCount: count,
      badgeColor: scheme.secondary,
      badgeTextColor: scheme.onSecondary,
    );
  }
}

class _AppbarButton extends StatelessWidget {
  const _AppbarButton({
    required this.icon,
    required this.onPressed,
    this.tooltip,
    this.badgeCount = 0,
    this.badgeColor,
    this.badgeTextColor,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final String? tooltip;
  final int badgeCount;
  final Color? badgeColor;
  final Color? badgeTextColor;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final enabled = onPressed != null;
    final fg = enabled
        ? scheme.onSurface
        : scheme.onSurface.withValues(alpha: 0.38);

    Widget glyph = Icon(icon, size: Dimens.iconBadge, color: fg);

    if (badgeCount > 0) {
      glyph = Badge.count(
        count: badgeCount,
        maxCount: 99,
        backgroundColor: badgeColor,
        textColor: badgeTextColor,
        child: glyph,
      );
    }

    final button = Material(
      color: scheme.surfaceContainerHighest,
      borderRadius: Dimens.borderMd,
      child: InkWell(
        onTap: onPressed,
        borderRadius: Dimens.borderMd,
        splashColor: scheme.primary.withValues(alpha: 0.08),
        highlightColor: AppColors.transparent,
        child: SizedBox(
          width: Dimens.badge,
          height: Dimens.badge,
          child: Center(child: glyph),
        ),
      ),
    );

    return tooltip == null ? button : Tooltip(message: tooltip!, child: button);
  }
}