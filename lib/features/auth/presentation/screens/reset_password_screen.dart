import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
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

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _otp = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();

  String get _email => GoRouterState.of(context).extra as String? ?? '';

  @override
  void dispose() {
    _otp.dispose();
    _password.dispose();
    _confirm.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    context.read<AuthCubit>().resetPassword(
      email: _email,
      otp: _otp.text.trim(),
      newPassword: _password.text,
    );
  }

  void _resend() {
    context.read<AuthCubit>().forgetPassword(ForgetPasswordParams(email: _email));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);

    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (_, curr) =>
      (curr.action == AuthAction.resetPassword ||
          curr.action == AuthAction.forgetPassword) &&
          (curr.status == RequestStatus.failure ||
              curr.status == RequestStatus.success),
      listener: (context, state) {
        if (state.status == RequestStatus.failure) {
          final message = state.failure?.localizedMessage(context) ?? '';
          if (message.isEmpty) return;
          AppToast.error(context, message);
        } else if (state.action == AuthAction.resetPassword) {
          AppToast.success(context, l10n.resetPasswordSuccess);
        } else {
          AppToast.success(context, l10n.verifyEmailOtpResent);
        }
      },
      child: AuthScaffold(
        title: l10n.resetPasswordTitle,
        subtitle: l10n.resetPasswordSubtitle(_email),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              AppTextField(
                controller: _otp,
                label: l10n.authOtp,
                hint: l10n.authOtpHint,
                prefixIcon: Icons.pin_outlined,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                textDirection: TextDirection.ltr,
                validator: (v) =>
                    AuthValidators.required(v, l10n.authOtpRequired),
              ),
              Dimens.gapLg,
              AppTextField(
                controller: _password,
                label: l10n.authNewPassword,
                hint: l10n.authNewPasswordHint,
                prefixIcon: Icons.lock_outline_rounded,
                isPassword: true,
                textInputAction: TextInputAction.next,
                textDirection: TextDirection.ltr,
                autofillHints: const [AutofillHints.newPassword],
                validator: AuthValidators.password(l10n),
              ),
              Dimens.gapLg,
              AppTextField(
                controller: _confirm,
                label: l10n.authConfirmPassword,
                hint: l10n.authConfirmPasswordHint,
                prefixIcon: Icons.lock_outline_rounded,
                isPassword: true,
                textInputAction: TextInputAction.done,
                textDirection: TextDirection.ltr,
                onSubmitted: (_) => _submit(),
                validator: (v) =>
                v == _password.text ? null : l10n.authPasswordsMismatch,
              ),
              Dimens.gapXl,
              _ResetButton(onPressed: _submit),
              Dimens.gapLg,
              _ResendButton(onPressed: _resend),
            ],
          ),
        ),
      ),
    );
  }
}

class _ResetButton extends StatelessWidget {
  const _ResetButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select(
          (AuthCubit c) =>
      c.state.action == AuthAction.resetPassword &&
          c.state.status == RequestStatus.loading,
    );
    return AppButton(
      label: S.of(context).resetPasswordButton,
      isLoading: isLoading,
      onPressed: onPressed,
    );
  }
}

class _ResendButton extends StatelessWidget {
  const _ResendButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select(
          (AuthCubit c) =>
      c.state.action == AuthAction.forgetPassword &&
          c.state.status == RequestStatus.loading,
    );
    return TextButton(
      onPressed: isLoading ? null : onPressed,
      child: Text(S.of(context).verifyEmailResend),
    );
  }
}