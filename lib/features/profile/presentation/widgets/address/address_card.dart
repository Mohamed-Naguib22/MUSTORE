import 'package:flutter/material.dart';
import 'package:mustore/core/style/dimens/dimens.dart';
import 'package:mustore/core/widgets/actions/app_popup_menu.dart';
import 'package:mustore/core/widgets/icons/icon_badge.dart';
import 'package:mustore/core/widgets/buttons/app_button.dart';
import 'package:mustore/core/widgets/cards/app_card.dart';
import 'package:mustore/features/profile/domain/entities/address.dart';
import 'package:mustore/generated/l10n.dart';

enum _AddressAction { edit, delete }

class AddressCard extends StatelessWidget {
  const AddressCard({
    super.key,
    required this.address,
    required this.onEdit,
    required this.onDelete,
    required this.onSetDefault,
  });

  final Address address;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback? onSetDefault;

  static const double _chipVerticalPadding = Dimens.xs + Dimens.xxs;

  List<({IconData icon, String label})> _details(S l10n) => [
    if (address.building != null)
      (
      icon: Icons.apartment_rounded,
      label: l10n.addressesBuilding(address.building!),
      ),
    if (address.floor != null)
      (
      icon: Icons.layers_outlined,
      label: l10n.addressesFloor(address.floor!),
      ),
    if (address.apartment != null)
      (
      icon: Icons.door_front_door_outlined,
      label: l10n.addressesApartment(address.apartment!),
      ),
    (
    icon: Icons.markunread_mailbox_outlined,
    label: address.postalCode,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final s = theme.colorScheme;
    final text = theme.textTheme;
    final l10n = S.of(context);
    final details = _details(l10n);
    final isDefault = address.isDefault;

    final cardColor = isDefault
        ? Color.alphaBlend(s.primaryContainer.withValues(alpha: 0.5), s.surface)
        : s.surface;
    final borderColor = isDefault
        ? s.primary.withValues(alpha: 0.25)
        : s.outlineVariant;

    final fieldColor = theme.scaffoldBackgroundColor;

    const contentPadding = EdgeInsetsDirectional.only(end: Dimens.sm);

    return AppCard(
      variant: AppCardVariant.outlined,
      color: cardColor,
      borderColor: borderColor,
      padding: const EdgeInsetsDirectional.fromSTEB(
        Dimens.lg,
        Dimens.lg,
        Dimens.sm,
        Dimens.lg,
      ),
      onTap: onEdit,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconBadge(
                icon: isDefault
                    ? Icons.home_rounded
                    : Icons.location_on_outlined,
                isHighlighted: isDefault,
              ),
              Dimens.gapMd,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            address.street,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: text.titleMedium,
                          ),
                        ),
                        if (isDefault) ...[
                          Dimens.gapSm,
                          const _DefaultChip(),
                        ],
                      ],
                    ),
                    const SizedBox(height: Dimens.xs),
                    Row(
                      children: [
                        Icon(
                          Icons.place_outlined,
                          size: Dimens.iconSm,
                          color: s.onSurfaceVariant,
                        ),
                        Dimens.gapXs,
                        Expanded(
                          child: Text(
                            '${address.city}, ${address.governorate}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: text.bodyMedium?.copyWith(
                              color: s.onSurfaceVariant,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              AppPopupMenu<_AddressAction>(
                onSelected: (a) => switch (a) {
                  _AddressAction.edit => onEdit(),
                  _AddressAction.delete => onDelete(),
                },
                items: [
                  AppPopupMenuItem(
                    value: _AddressAction.edit,
                    label: l10n.addressesMenuEdit,
                    icon: Icons.edit_outlined,
                  ),
                  AppPopupMenuItem(
                    value: _AddressAction.delete,
                    label: l10n.addressesMenuDelete,
                    icon: Icons.delete_outline_rounded,
                    isDestructive: true,
                    dividerBefore: true,
                  ),
                ],
              ),
            ],
          ),
          Dimens.gapLg,
          Padding(
            padding: contentPadding,
            child: Wrap(
              spacing: Dimens.sm,
              runSpacing: Dimens.sm,
              children: [
                for (final d in details)
                  _DetailChip(
                    icon: d.icon,
                    label: d.label,
                    color: fieldColor,
                    verticalPadding: _chipVerticalPadding,
                  ),
              ],
            ),
          ),
          if (address.additionalInfo != null) ...[
            Dimens.gapMd,
            Padding(
              padding: contentPadding,
              child: _NoteBlock(
                message: address.additionalInfo!,
                color: fieldColor,
              ),
            ),
          ],
          if (onSetDefault != null) ...[
            Dimens.gapMd,
            Padding(
              padding: contentPadding,
              child: AppButton(
                label: l10n.addressesMenuSetDefault,
                icon: Icons.check_circle_outline_rounded,
                variant: AppButtonVariant.tonal,
                height: 44,
                onPressed: onSetDefault,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _DetailChip extends StatelessWidget {
  const _DetailChip({
    required this.icon,
    required this.label,
    required this.color,
    required this.verticalPadding,
  });

  final IconData icon;
  final String label;
  final Color color;
  final double verticalPadding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final s = theme.colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: color,
        borderRadius: Dimens.borderSm,
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.symmetric(
          horizontal: Dimens.md,
          vertical: verticalPadding,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: Dimens.iconSm, color: s.onSurfaceVariant),
            Dimens.gapXs,
            Flexible(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.labelMedium?.copyWith(
                  color: s.onSurface,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NoteBlock extends StatelessWidget {
  const _NoteBlock({required this.message, required this.color});

  final String message;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final s = theme.colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: color,
        borderRadius: Dimens.borderMd,
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: Dimens.md,
          vertical: Dimens.md,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.only(top: Dimens.xxs),
              child: Icon(
                Icons.info_outline_rounded,
                size: Dimens.iconSm,
                color: s.onSurfaceVariant,
              ),
            ),
            Dimens.gapSm,
            Expanded(
              child: Text(
                message,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: s.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DefaultChip extends StatelessWidget {
  const _DefaultChip();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final s = theme.colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: s.primaryContainer,
        borderRadius: Dimens.borderPill,
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: Dimens.md,
          vertical: Dimens.xs,
        ),
        child: Text(
          S.of(context).addressesDefaultBadge,
          style: theme.textTheme.labelMedium?.copyWith(
            color: s.onPrimaryContainer,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}