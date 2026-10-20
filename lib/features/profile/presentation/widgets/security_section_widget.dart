import 'package:flutter/material.dart';
import 'package:mustore/core/widgets/lists/app_list_tile.dart';
import 'package:mustore/features/profile/presentation/widgets/sign_out_tile_widget.dart';
import 'package:mustore/generated/l10n.dart';
import 'account_section_widget.dart';

class SecuritySectionWidget extends StatelessWidget {
  const SecuritySectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);

    return AccountSectionWidget(
      title: l10n.settingsAccount,
      children: [
        AppListTile(
          icon: Icons.lock_outline_rounded,
          title: l10n.accountSecurity,
          onTap: () {},
        ),
        const SignOutTileWidget(),
      ],
    );
  }
}