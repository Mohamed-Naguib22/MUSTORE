import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mustore/app/app_page.dart';
import 'package:mustore/core/error/failure_message.dart';
import 'package:mustore/core/style/dimens/dimens.dart';
import 'package:mustore/core/utils/enums/request_status.dart';
import 'package:mustore/core/validators/app_validators.dart';
import 'package:mustore/core/widgets/buttons/app_button.dart';
import 'package:mustore/core/widgets/buttons/app_text_button.dart';
import 'package:mustore/core/widgets/feedback/app_toast.dart';
import 'package:mustore/core/widgets/inputs/app_text_field.dart';
import 'package:mustore/features/auth/presentation/controllers/auth_cubit.dart';
import 'package:mustore/features/auth/presentation/controllers/auth_state.dart';
import 'package:mustore/features/auth/presentation/widgets/auth_scaffold.dart';
import 'package:mustore/features/auth/presentation/widgets/external_login_widget.dart';
import 'package:mustore/generated/l10n.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    context.read<AuthCubit>().login(
      email: _email.text.trim(),
      password: _password.text,
    );
  }

  void _openRegister() {
    context.pushNamed(
      AppPage.register.name,
    );
  }

  void _openForgetPassword() {
    context.pushNamed(AppPage.forgetPassword.name);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = S.of(context);

    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (_, curr) =>
      curr.action == AuthAction.login &&
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
      child: AuthScaffold(
        title: l10n.loginTitle,
        subtitle: l10n.loginSubtitle,
        child: Form(
          key: _formKey,
          child: AutofillGroup(
            child: Column(
              children: [
                AppTextField(
                  controller: _email,
                  label: l10n.authEmail,
                  hint: l10n.authEmailHint,
                  prefixIcon: Icons.mail_outline_rounded,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  textDirection: TextDirection.ltr,
                  autofillHints: const [AutofillHints.email],
                  validator: AppValidators.email(l10n),
                ),
                Dimens.gapLg,
                AppTextField(
                  controller: _password,
                  label: l10n.authPassword,
                  hint: l10n.authPasswordHint,
                  prefixIcon: Icons.lock_outline_rounded,
                  isPassword: true,
                  textInputAction: TextInputAction.done,
                  textDirection: TextDirection.ltr,
                  autofillHints: const [AutofillHints.password],
                  onSubmitted: (_) => _submit(),
                  validator: AppValidators.required(l10n.authPasswordRequired),
                ),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: AppTextButton(
                    label: l10n.authForgotPassword,
                    onPressed: _openForgetPassword,
                    compact: true,
                  ),
                ),
                Dimens.gapSm,
                _LoginButton(onPressed: _submit),
                Dimens.gapXl,
                const ExternalLoginWidget(),
                Dimens.gapXl,
                Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      l10n.authNoAccount,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    AppTextButton(
                      label: l10n.authSignUp,
                      onPressed: _openRegister,
                      compact: true,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select(
          (AuthCubit c) =>
      c.state.action == AuthAction.login &&
          c.state.status == RequestStatus.loading,
    );
    return AppButton(
      label: S.of(context).authLogIn,
      isLoading: isLoading,
      onPressed: onPressed,
    );
  }
}