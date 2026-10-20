import 'package:flutter/material.dart';
import 'package:mustore/core/style/dimens/dimens.dart';
import 'package:mustore/core/widgets/buttons/app_icon_button.dart';
import 'package:mustore/core/widgets/cards/app_card.dart';
import 'package:mustore/features/auth/domain/entities/auth_session.dart';
import 'package:mustore/features/profile/presentation/widgets/account_avatar_widget.dart';

class ProfileCardWidget extends StatelessWidget {
  const ProfileCardWidget({
    super.key,
    required this.session,
    required this.onEdit,
    required this.editTooltip,
  });

  final AuthSession? session;
  final VoidCallback onEdit;
  final String editTooltip;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;

    final fullName =
    '${session?.firstName ?? ''} ${session?.lastName ?? ''}'.trim();

    return AppCard(
      onTap: onEdit,
      child: Row(
        children: [
          AccountAvatarWidget(url: session?.profilePictureUrl, name: fullName),
          Dimens.gapMd,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  fullName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: text.titleSmall,
                ),
                const SizedBox(height: Dimens.xxs),
                Text(
                  session?.email ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: text.bodySmall?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Dimens.gapSm,
          AppIconButton(
            icon: Icons.edit_outlined,
            tooltip: editTooltip,
            onPressed: onEdit,
          ),
        ],
      ),
    );
  }
}