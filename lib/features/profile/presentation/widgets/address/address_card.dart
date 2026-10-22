import 'package:flutter/material.dart';
import 'package:mustore/core/style/dimens/dimens.dart';
import 'package:mustore/core/widgets/cards/app_card.dart';
import 'package:mustore/features/profile/domain/entities/address.dart';
import 'package:mustore/generated/l10n.dart';

enum _AddressAction { edit, setDefault, delete }

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

  String _details(S l10n) => [
    if (address.building != null)
      l10n.addressesBuilding(address.building!),
    if (address.floor != null) l10n.addressesFloor(address.floor!),
    if (address.apartment != null)
      l10n.addressesApartment(address.apartment!),
  ].join(' · ');

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final s = theme.colorScheme;
    final text = theme.textTheme;
    final l10n = S.of(context);
    final details = _details(l10n);

    return AppCard(
      variant: AppCardVariant.outlined,
      borderColor: address.isDefault ? s.primary : s.outlineVariant,
      onTap: onEdit,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: Dimens.badge,
            height: Dimens.badge,
            decoration: BoxDecoration(
              color: address.isDefault
                  ? s.primaryContainer
                  : s.surfaceContainerHighest,
              borderRadius: Dimens.borderMd,
            ),
            child: Icon(
              address.isDefault
                  ? Icons.home_rounded
                  : Icons.location_on_outlined,
              size: Dimens.iconBadge,
              color: address.isDefault
                  ? s.onPrimaryContainer
                  : s.onSurfaceVariant,
            ),
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
                        style: text.titleSmall,
                      ),
                    ),
                    if (address.isDefault) ...[
                      Dimens.gapSm,
                      const _DefaultChip(),
                    ],
                  ],
                ),
                if (details.isNotEmpty) ...[
                  const SizedBox(height: Dimens.xxs),
                  Text(
                    details,
                    style: text.bodySmall?.copyWith(color: s.onSurfaceVariant),
                  ),
                ],
                const SizedBox(height: Dimens.xxs),
                Text(
                  '${address.city}, ${address.governorate} · ${address.postalCode}',
                  style: text.bodySmall?.copyWith(color: s.onSurfaceVariant),
                ),
                if (address.additionalInfo != null) ...[
                  const SizedBox(height: Dimens.xxs),
                  Text(
                    address.additionalInfo!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: text.bodySmall?.copyWith(color: s.onSurfaceVariant),
                  ),
                ],
              ],
            ),
          ),
          PopupMenuButton<_AddressAction>(
            icon: Icon(Icons.more_vert_rounded, color: s.onSurfaceVariant),
            padding: EdgeInsets.zero,
            onSelected: (a) => switch (a) {
              _AddressAction.edit => onEdit(),
              _AddressAction.setDefault => onSetDefault?.call(),
              _AddressAction.delete => onDelete(),
            },
            itemBuilder: (_) => [
              PopupMenuItem(
                value: _AddressAction.edit,
                child: Text(l10n.addressesMenuEdit),
              ),
              if (onSetDefault != null)
                PopupMenuItem(
                  value: _AddressAction.setDefault,
                  child: Text(l10n.addressesMenuSetDefault),
                ),
              PopupMenuItem(
                value: _AddressAction.delete,
                child: Text(
                  l10n.addressesMenuDelete,
                  style: TextStyle(color: s.error),
                ),
              ),
            ],
          ),
        ],
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

    return Container(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: Dimens.sm,
        vertical: Dimens.xxs,
      ),
      decoration: BoxDecoration(
        color: s.primaryContainer,
        borderRadius: Dimens.borderPill,
      ),
      child: Text(
        S.of(context).addressesDefaultBadge,
        style: theme.textTheme.labelMedium?.copyWith(
          color: s.onPrimaryContainer,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}