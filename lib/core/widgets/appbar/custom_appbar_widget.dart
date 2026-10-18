import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mustore/core/style/colors/app_colors.dart';

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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isDark = scheme.brightness == Brightness.dark;

    final ShapeBorder? shape = borderRadius != null
        ? RoundedRectangleBorder(borderRadius: borderRadius!)
        : showDivider
        ? Border(bottom: BorderSide(color: scheme.outline))
        : null;

    return AppBar(
      elevation: elevation,
      scrolledUnderElevation: 0,
      surfaceTintColor: AppColors.transparent,
      backgroundColor: backgroundColor ?? scheme.surface,
      foregroundColor: scheme.onSurface,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: AppColors.transparent,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
      ),
      automaticallyImplyLeading: automaticallyImplyLeading,
      leading: leading,
      title: titleWidget ??
          (title == null
              ? null
              : Text(
            title!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.titleLarge,
          )),
      centerTitle: centerTitle,
      actions: actions,
      bottom: bottom,
      shape: shape,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
    kToolbarHeight + (bottom?.preferredSize.height ?? 0),
  );
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

    return IconButton(
      tooltip: tooltip,
      onPressed: onPressed,
      color: scheme.onSurface,
      icon: Badge.count(
        count: count,
        maxCount: 99,
        isLabelVisible: count > 0,
        backgroundColor: scheme.secondary,
        textColor: scheme.onSecondary,
        child: Icon(icon),
      ),
    );
  }
}