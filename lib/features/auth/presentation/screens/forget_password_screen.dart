import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mustore/app/app_page.dart';
import 'package:mustore/core/error/failure_message.dart';
import 'package:mustore/core/style/dimens/dimens.dart';
import 'package:mustore/core/utils/enums/request_status.dart';
import 'package:mustore/core/widgets/buttons/app_button.dart';
import 'package:mustore/core/widgets/feedback/app_toast.dart';
import 'package:mustore/core/widgets/inputs/app_text_field.dart';
import 'package:mustore/features/auth/domain/params/forget_password_params.dart';
import 'package:mustore/features/auth/presentation/controllers/auth_cubit.dart';
import 'package:mustore/features/auth/presentation/controllers/auth_state.dart';
import 'package:mustore/features/auth/presentation/widgets/auth_scaffold.dart';
import 'package:mustore/generated/l10n.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    context.read<AuthCubit>().forgetPassword(
      ForgetPasswordParams(email: _email.text.trim()),
    );
  }

  void _openLogin() {
    if (context.canPop()) {
      context.pop();
    } else {
      context.goNamed(AppPage.login.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = S.of(context);

    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (_, curr) =>
      curr.action == AuthAction.forgetPassword &&
          (curr.status == RequestStatus.failure ||
              curr.status == RequestStatus.success),
      listener: (context, state) {
        if (state.status == RequestStatus.failure) {
          final message = state.failure?.localizedMessage(context) ?? '';
          if (message.isEmpty) return;
          AppToast.error(context, message);
        } else {
          AppToast.success(context, l10n.forgetPasswordSuccess);
          context.pushReplacementNamed(
            AppPage.resetPassword.name,
            extra: _email.text.trim(),
          );
        }
      },
      child: AuthScaffold(
        title: l10n.forgetPasswordTitle,
        subtitle: l10n.forgetPasswordSubtitle,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              AppTextField(
                controller: _email,
                label: l10n.authEmail,
                hint: l10n.authEmailHint,
                prefixIcon: Icons.mail_outline_rounded,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
                textDirection: TextDirection.ltr,
                autofillHints: const [AutofillHints.email],
                onSubmitted: (_) => _submit(),
                validator: AuthValidators.email(l10n),
              ),
              Dimens.gapXl,
              _SendButton(onPressed: _submit),
              Dimens.gapXl,
              Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    l10n.authRememberPassword,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  TextButton(
                    onPressed: _openLogin,
                    child: Text(l10n.authLogIn),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SendButton extends StatelessWidget {
  const _SendButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select(
          (AuthCubit c) =>
      c.state.action == AuthAction.forgetPassword &&
          c.state.status == RequestStatus.loading,
    );
    return AppButton(
      label: S.of(context).forgetPasswordButton,
      isLoading: isLoading,
      onPressed: onPressed,
    );
  }
}