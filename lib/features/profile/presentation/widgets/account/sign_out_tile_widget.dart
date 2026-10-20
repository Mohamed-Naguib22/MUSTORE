import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mustore/core/style/dimens/dimens.dart';
import 'package:mustore/core/utils/enums/request_status.dart';
import 'package:mustore/core/widgets/lists/app_list_tile.dart';
import 'package:mustore/features/auth/presentation/controllers/auth_cubit.dart';
import 'package:mustore/features/auth/presentation/controllers/auth_state.dart';
import 'package:mustore/generated/l10n.dart';

class SignOutTileWidget extends StatelessWidget {
  const SignOutTileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    final isLoading = context.select(
          (AuthCubit c) =>
      c.state.action == AuthAction.revokeSession &&
          c.state.status == RequestStatus.loading,
    );

    return AppListTile(
      icon: Icons.logout_rounded,
      title: S.of(context).authLogOut,
      isDestructive: true,
      showChevron: false,
      onTap: isLoading ? null : () => context.read<AuthCubit>().logout(),
      trailing: isLoading
          ? SizedBox(
        width: Dimens.iconMd - Dimens.xs,
        height: Dimens.iconMd - Dimens.xs,
        child: CircularProgressIndicator(
          strokeWidth: Dimens.xxs,
          color: scheme.error,
        ),
      )
          : null,
    );
  }
}