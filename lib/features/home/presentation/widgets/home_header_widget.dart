import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mustore/core/style/dimens/dimens.dart';
import 'package:mustore/features/home/presentation/controllers/home_cubit.dart';
import 'package:mustore/generated/l10n.dart';

class HomeHeaderWidget extends StatelessWidget {
  const HomeHeaderWidget({
    super.key,
    this.notificationCount = 2,
    this.onLocationTap,
    this.onFavoritesTap,
    this.onNotificationsTap,
  });

  final int notificationCount;
  final VoidCallback? onLocationTap;
  final VoidCallback? onFavoritesTap;
  final VoidCallback? onNotificationsTap;

  static const double _tile = Dimens.iconLg;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    final l10n = S.of(context);

    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
        Dimens.lg,
        Dimens.md,
        Dimens.lg,
        Dimens.xs,
      ),
      child: Row(
        children: [
          Expanded(
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: InkWell(
                onTap: onLocationTap,
                borderRadius: Dimens.borderMd,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: _tile,
                      height: _tile,
                      decoration: BoxDecoration(
                        color: scheme.primaryContainer,
                        borderRadius: Dimens.borderMd,
                      ),
                      child: Icon(
                        Icons.location_on_rounded,
                        color: scheme.onPrimaryContainer,
                      ),
                    ),
                    Dimens.gapSm,
                    Flexible(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.homeDeliverTo,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: text.bodySmall?.copyWith(
                              color: scheme.onSurfaceVariant,
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Flexible(
                                child: BlocBuilder<HomeCubit, HomeState>(
                                  buildWhen: (p, c) => p.location != c.location,
                                  builder: (context, state) {
                                    return Text(
                                      state.location ??
                                          l10n.homeLocationFallback,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: text.titleSmall,
                                    );
                                  },
                                ),
                              ),
                              Dimens.gapXxs,
                              Icon(
                                Icons.keyboard_arrow_down_rounded,
                                size: Dimens.iconSm,
                                color: scheme.onSurfaceVariant,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Dimens.gapSm,
          _ActionButton(
            icon: Icons.favorite_border_rounded,
            onTap: onFavoritesTap,
          ),
          Dimens.gapSm,
          _ActionButton(
            icon: Icons.notifications_none_rounded,
            badgeCount: notificationCount,
            onTap: onNotificationsTap,
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    this.onTap,
    this.badgeCount = 0,
  });

  final IconData icon;
  final VoidCallback? onTap;
  final int badgeCount;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    Widget child = Icon(icon, color: scheme.onSurface);
    if (badgeCount > 0) {
      child = Badge.count(
        count: badgeCount,
        backgroundColor: scheme.error,
        textColor: scheme.onError,
        child: child,
      );
    }

    return Material(
      color: scheme.surfaceContainerHighest,
      borderRadius: Dimens.borderMd,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap ?? () {},
        child: SizedBox(
          width: HomeHeaderWidget._tile,
          height: HomeHeaderWidget._tile,
          child: Center(child: child),
        ),
      ),
    );
  }
}