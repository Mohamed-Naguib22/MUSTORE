import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mustore/core/error/failure_message.dart';
import 'package:mustore/core/utils/enums/request_status.dart';
import 'package:mustore/core/widgets/bottom_sheets/app_confirmation_sheet.dart';
import 'package:mustore/core/widgets/bottom_sheets/app_options_sheet.dart';
import 'package:mustore/core/widgets/feedback/app_toast.dart';
import 'package:mustore/core/widgets/lists/app_list_tile.dart';
import 'package:mustore/features/auth/presentation/controllers/auth_cubit.dart';
import 'package:mustore/features/profile/presentation/controllers/account/profile_cubit.dart';
import 'package:mustore/features/profile/presentation/controllers/account/profile_state.dart';
import 'package:mustore/features/profile/presentation/widgets/account/sign_out_tile_widget.dart';
import 'package:mustore/generated/l10n.dart';
import 'account_section_widget.dart';

enum _SecurityAction { deleteAccount }

class SecuritySectionWidget extends StatelessWidget {
  const SecuritySectionWidget({super.key});

  Future<void> _openOptions(BuildContext context) async {
    final l10n = S.of(context);

    final action = await AppOptionsSheet.show<_SecurityAction>(
      context,
      options: [
        AppOption(
          value: _SecurityAction.deleteAccount,
          label: l10n.accountDeleteAccount,
          icon: Icons.delete_outline_rounded,
          isDestructive: true,
        ),
      ],
    );

    if (action == null || !context.mounted) return;

    switch (action) {
      case _SecurityAction.deleteAccount:
        await _confirmDeleteAccount(context);
    }
  }

  Future<void> _confirmDeleteAccount(BuildContext context) async {
    final l10n = S.of(context);

    final confirmed = await AppConfirmationSheet.show(
      context,
      title: l10n.accountDeleteAccountConfirmTitle,
      message: l10n.accountDeleteAccountConfirmMessage,
      confirmLabel: l10n.commonDelete,
      cancelLabel: l10n.commonCancel,
      icon: Icons.delete_outline_rounded,
      isDestructive: true,
    );

    if (!confirmed || !context.mounted) return;

    await context.read<ProfileCubit>().deleteAccount();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);

    return BlocListener<ProfileCubit, ProfileState>(
      listenWhen: (p, c) => p.deleteAccountStatus != c.deleteAccountStatus,
      listener: (context, state) {
        switch (state.deleteAccountStatus) {
          case RequestStatus.success:
            context.read<AuthCubit>().logout();
          case RequestStatus.failure:
            final message = state.failure?.localizedMessage(context) ?? '';
            AppToast.error(
              context,
              message.isEmpty ? l10n.commonSomethingWentWrong : message,
            );
          default:
            break;
        }
      },
      child: AccountSectionWidget(
        title: l10n.settingsAccount,
        children: [
          AppListTile(
            icon: Icons.lock_outline_rounded,
            title: l10n.accountSecurity,
            onTap: () => _openOptions(context),
          ),
          const SignOutTileWidget(),
        ],
      ),
    );
  }
}