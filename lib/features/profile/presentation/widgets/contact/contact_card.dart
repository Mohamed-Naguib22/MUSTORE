import 'package:flutter/material.dart';
import 'package:mustore/core/style/dimens/dimens.dart';
import 'package:mustore/core/widgets/actions/app_popup_menu.dart';
import 'package:mustore/core/widgets/buttons/app_button.dart';
import 'package:mustore/core/widgets/cards/app_card.dart';
import 'package:mustore/core/widgets/icons/app_icon_badge.dart';
import 'package:mustore/features/profile/domain/entities/contact.dart';
import 'package:mustore/generated/l10n.dart';

enum _ContactAction { edit, delete }

class ContactCard extends StatelessWidget {
  const ContactCard({
    super.key,
    required this.contact,
    required this.onEdit,
    required this.onDelete,
    required this.onSetPrimary,
    required this.onVerify,
  });

  final Contact contact;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback? onSetPrimary;
  final VoidCallback? onVerify;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final s = theme.colorScheme;
    final text = theme.textTheme;
    final l10n = S.of(context);
    final isPrimary = contact.isPrimary;
    final isVerified = contact.isVerified;

    final cardColor = isPrimary
        ? Color.alphaBlend(s.primaryContainer.withValues(alpha: 0.5), s.surface)
        : s.surface;
    final borderColor = isPrimary
        ? s.primary.withValues(alpha: 0.25)
        : s.outlineVariant;

    final statusColor = isVerified ? s.primary : s.error;

    const contentPadding = EdgeInsetsDirectional.only(end: Dimens.sm);
    final hasActions = onVerify != null || onSetPrimary != null;

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
              AppIconBadge(
                icon: isPrimary
                    ? Icons.phone_in_talk_rounded
                    : Icons.phone_outlined,
                isHighlighted: isPrimary,
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
                            contact.phoneNumber,
                            textDirection: TextDirection.ltr,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: text.titleSmall,
                          ),
                        ),
                        if (isPrimary) ...[
                          Dimens.gapSm,
                          const _PrimaryChip(),
                        ],
                      ],
                    ),
                    const SizedBox(height: Dimens.xs),
                    Row(
                      children: [
                        Icon(
                          isVerified
                              ? Icons.verified_rounded
                              : Icons.error_outline_rounded,
                          size: Dimens.iconSm,
                          color: statusColor,
                        ),
                        Dimens.gapXs,
                        Expanded(
                          child: Text(
                            isVerified
                                ? l10n.contactsVerifiedBadge
                                : l10n.contactsUnverifiedBadge,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: text.bodySmall?.copyWith(
                              color: statusColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              AppPopupMenu<_ContactAction>(
                onSelected: (a) => switch (a) {
                  _ContactAction.edit => onEdit(),
                  _ContactAction.delete => onDelete(),
                },
                items: [
                  AppPopupMenuItem(
                    value: _ContactAction.edit,
                    label: l10n.contactsMenuEdit,
                    icon: Icons.edit_outlined,
                  ),
                  if (!isPrimary)
                    AppPopupMenuItem(
                      value: _ContactAction.delete,
                      label: l10n.contactsMenuDelete,
                      icon: Icons.delete_outline_rounded,
                      isDestructive: true,
                      dividerBefore: true,
                    ),
                ],
              ),
            ],
          ),
          if (hasActions) ...[
            Dimens.gapLg,
            Padding(
              padding: contentPadding,
              child: Row(
                children: [
                  if (onVerify != null)
                    Expanded(
                      child: AppButton(
                        label: l10n.contactsVerifyAction,
                        icon: Icons.verified_user_outlined,
                        variant: AppButtonVariant.tonal,
                        height: Dimens.buttonHeightSm,
                        fontSize: Dimens.fontSm,
                        onPressed: onVerify,
                      ),
                    ),
                  if (onVerify != null && onSetPrimary != null) Dimens.gapMd,
                  if (onSetPrimary != null)
                    Expanded(
                      child: AppButton(
                        label: l10n.contactsMenuSetPrimary,
                        icon: Icons.check_circle_outline_rounded,
                        variant: AppButtonVariant.outlined,
                        height: Dimens.buttonHeightSm,
                        fontSize: Dimens.fontSm,
                        onPressed: onSetPrimary,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _PrimaryChip extends StatelessWidget {
  const _PrimaryChip();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final s = theme.colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: s.secondary,
        borderRadius: Dimens.borderPill,
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: Dimens.md,
          vertical: Dimens.xs,
        ),
        child: Text(
          S.of(context).contactsPrimaryBadge,
          style: theme.textTheme.labelSmall?.copyWith(
            color: s.onSecondary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}