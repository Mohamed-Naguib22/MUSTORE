import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mustore/core/error/failure_message.dart';
import 'package:mustore/core/style/dimens/dimens.dart';
import 'package:mustore/core/utils/constants/app_assets.dart';
import 'package:mustore/core/utils/enums/request_status.dart';
import 'package:mustore/core/widgets/buttons/app_button.dart';
import 'package:mustore/core/widgets/feedback/app_toast.dart';
import 'package:mustore/core/widgets/media/app_asset.dart';
import 'package:mustore/features/auth/domain/enums/login_provider.dart';
import 'package:mustore/features/auth/presentation/controllers/auth_cubit.dart';
import 'package:mustore/features/auth/presentation/controllers/auth_state.dart';
import 'package:mustore/generated/l10n.dart';

class ExternalLoginWidget extends StatelessWidget {
  const ExternalLoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = S.of(context);

    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (_, curr) =>
      curr.action == AuthAction.externalLogin &&
          (curr.status == RequestStatus.failure ||
              curr.status == RequestStatus.success),
      listener: (context, state) {
        if (state.status == RequestStatus.failure) {
          final message = state.failure?.localizedMessage(context) ?? '';
          if (message.isEmpty) return;
          AppToast.error(context, message);
        } else {
          AppToast.success(context, l10n.loginSuccess);
        }
      },
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: Divider(color: theme.colorScheme.outlineVariant)),
              Padding(
                padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: Dimens.lg,
                ),
                child: Text(
                  l10n.authOr,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
              Expanded(child: Divider(color: theme.colorScheme.outlineVariant)),
            ],
          ),
          Dimens.gapLg,
          const _GoogleButton(),
        ],
      ),
    );
  }
}

class _GoogleButton extends StatelessWidget {
  const _GoogleButton();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    final isLoading = context.select(
          (AuthCubit c) =>
      c.state.action == AuthAction.externalLogin &&
          c.state.status == RequestStatus.loading,
    );

    const logo = AppAsset(
      AppAssets.google,
      width: Dimens.iconMd - Dimens.xs,
      height: Dimens.iconMd - Dimens.xs,
    );

    return AppButton(
      label: S.of(context).authContinueWithGoogle,
      variant: AppButtonVariant.tonal,
      backgroundColor: scheme.surfaceContainerHighest,
      foregroundColor: scheme.onSurface,
      isLoading: isLoading,
      leading: isRtl ? null : logo,
      trailing: isRtl ? logo : null,
      onPressed: () =>
          context.read<AuthCubit>().externalLogin(LoginProvider.google),
    );
  }
}