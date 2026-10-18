import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mustore/core/error/failure_message.dart';
import 'package:mustore/core/style/dimens/dimens.dart';
import 'package:mustore/core/utils/enums/request_status.dart';
import 'package:mustore/core/widgets/feedback/app_toast.dart';
import 'package:mustore/features/auth/domain/enums/login_provider.dart';
import 'package:mustore/features/auth/presentation/controllers/auth_cubit.dart';
import 'package:mustore/features/auth/presentation/controllers/auth_state.dart';
import 'package:mustore/generated/l10n.dart';

class ExternalLoginSectionWidget extends StatelessWidget {
  const ExternalLoginSectionWidget({super.key});

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
              const Expanded(child: Divider()),
              Padding(
                padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: Dimens.md,
                ),
                child: Text(
                  l10n.authOr,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
              const Expanded(child: Divider()),
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
    final isLoading = context.select(
          (AuthCubit c) =>
      c.state.action == AuthAction.externalLogin &&
          c.state.status == RequestStatus.loading,
    );

    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: isLoading
            ? null
            : () => context.read<AuthCubit>().externalLogin(LoginProvider.google),
        icon: isLoading
            ? const SizedBox.square(
          dimension: 18,
          child: CircularProgressIndicator(strokeWidth: 2),
        )
            : const Icon(Icons.g_mobiledata_rounded, size: 28),
        label: Text(S.of(context).authContinueWithGoogle),
      ),
    );
  }
}