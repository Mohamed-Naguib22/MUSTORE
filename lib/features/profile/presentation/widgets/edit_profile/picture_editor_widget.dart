import 'package:flutter/material.dart';
import 'package:mustore/core/style/dimens/dimens.dart';
import 'package:mustore/core/widgets/buttons/app_icon_button.dart';
import 'package:mustore/core/widgets/media/app_network_image.dart';

class PictureEditorWidget extends StatelessWidget {
  const PictureEditorWidget({
    super.key,
    required this.url,
    required this.isBusy,
    required this.onTap,
  });

  final String url;
  final bool isBusy;
  final VoidCallback? onTap;

  static const double _size = Dimens.iconXl + Dimens.lg;
  static const double _badge = Dimens.xl + Dimens.xs;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final enabled = onTap != null && !isBusy;

    return SizedBox(
      width: _size,
      height: _size,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: ClipOval(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  AppNetworkImage(
                    url: url,
                    width: _size,
                    height: _size,
                    fallbackIcon: Icons.person_rounded,
                  ),
                  if (isBusy)
                    ColoredBox(
                      color: scheme.surface.withValues(alpha: 0.7),
                      child: const Center(
                        child: SizedBox(
                          width: Dimens.iconMd,
                          height: Dimens.iconMd,
                          child: CircularProgressIndicator(
                            strokeWidth: Dimens.xxs,
                          ),
                        ),
                      ),
                    ),
                  Material(
                    type: MaterialType.transparency,
                    child: InkWell(onTap: enabled ? onTap : null),
                  ),
                ],
              ),
            ),
          ),
          PositionedDirectional(
            end: -Dimens.xxs,
            bottom: -Dimens.xxs,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: theme.scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(
                  Dimens.radiusMd + Dimens.xxs,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(Dimens.xxs),
                child: AppIconButton(
                  icon: Icons.edit_rounded,
                  onPressed: enabled ? onTap : null,
                  size: _badge,
                  iconSize: Dimens.iconSm,
                  variant: AppIconButtonVariant.primary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}