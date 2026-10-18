import 'package:flutter/material.dart';

class CustomAppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? leading;
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
    this.leading,
    this.actions,
    this.bottom,
    this.centerTitle = true,
    this.backgroundColor,
    this.elevation = 0,
    this.borderRadius,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return AppBar(
      elevation: elevation,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      backgroundColor: backgroundColor ?? scheme.surface,
      foregroundColor: scheme.onSurface,
      leading: leading,
      title: title != null
          ? Text(
        title!,
        style: theme.textTheme.titleLarge?.copyWith(
          color: scheme.onSurface,
          fontWeight: FontWeight.bold,
        ),
      )
          : null,
      centerTitle: centerTitle,
      actions: actions,
      bottom: bottom,
      shape: borderRadius != null
          ? RoundedRectangleBorder(borderRadius: borderRadius!)
          : showDivider
          ? Border(bottom: BorderSide(color: scheme.outline))
          : null,
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
      icon: Badge(
        isLabelVisible: count > 0,
        label: Text(count > 99 ? '99+' : '$count'),
        backgroundColor: scheme.secondary,
        textColor: scheme.onSecondary,
        child: Icon(icon, color: scheme.onSurface),
      ),
    );
  }
}