import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mustore/app/app_page.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: const Icon(Icons.edit_outlined),
          title: const Text('Edit profile'),
          trailing: const Icon(Icons.chevron_right_rounded),
          onTap: () => context.pushNamed(AppPage.editProfile.name),
        ),
      ],
    );
  }
}