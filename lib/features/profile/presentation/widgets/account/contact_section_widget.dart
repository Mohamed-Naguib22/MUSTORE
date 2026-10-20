import 'package:flutter/material.dart';
import 'package:mustore/core/widgets/lists/app_list_tile.dart';
import 'package:mustore/generated/l10n.dart';
import 'account_section_widget.dart';

class ContactSectionWidget extends StatelessWidget {
  const ContactSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);

    return AccountSectionWidget(
      title: l10n.accountContact,
      children: [
        AppListTile(
          icon: Icons.location_on_outlined,
          title: l10n.accountAddresses,
          onTap: () {},
        ),
        AppListTile(
          icon: Icons.phone_outlined,
          title: l10n.accountPhoneNumbers,
          onTap: () {},
        ),
      ],
    );
  }
}