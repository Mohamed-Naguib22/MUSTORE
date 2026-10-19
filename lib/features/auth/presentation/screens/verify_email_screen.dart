import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mustore/core/error/failure_message.dart';
import 'package:mustore/core/style/dimens/dimens.dart';
import 'package:mustore/core/utils/enums/request_status.dart';
import 'package:mustore/core/validators/app_validators.dart';
import 'package:mustore/core/widgets/buttons/app_button.dart';
import 'package:mustore/core/widgets/buttons/app_text_button.dart';
import 'package:mustore/core/widgets/feedback/app_toast.dart';
import 'package:mustore/core/widgets/inputs/app_text_field.dart';
import 'package:mustore/features/auth/domain/params/resend_otp_params.dart';
import 'package:mustore/features/auth/presentation/controllers/auth_cubit.dart';
import 'package:mustore/features/auth/presentation/controllers/auth_state.dart';
import 'package:mustore/features/auth/presentation/widgets/auth_scaffold.dart';
import 'package:mustore/generated/l10n.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  final _formKey = GlobalKey<FormState>();
  final _otp = TextEditingController();

  String get _email => GoRouterState.of(context).extra as String? ?? '';

  @override
  void dispose() {
    _otp.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    context.read<AuthCubit>().verifyEmail(
      email: _email,
      otp: _otp.text.trim(),
    );
  }

  void _resend() {
    context.read<AuthCubit>().resendOtp(ResendOtpParams(email: _email));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);

    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (_, curr) =>
      (curr.action == AuthAction.verifyEmail ||
          curr.action == AuthAction.resendOtp) &&
          (curr.status == RequestStatus.failure ||
              curr.status == RequestStatus.success),
      listener: (context, state) {
        if (state.status == RequestStatus.failure) {
          final message = state.failure?.localizedMessage(context) ?? '';
          if (message.isEmpty) return;
          AppToast.error(context, message);
        } else if (state.action == AuthAction.verifyEmail) {
          AppToast.success(context, l10n.verifyEmailSuccess);
        } else {
          AppToast.success(context, l10n.verifyEmailOtpResent);
        }
      },
      child: AuthScaffold(
        title: l10n.verifyEmailTitle,
        subtitle: l10n.verifyEmailSubtitle(_email),
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
                textInputAction: TextInputAction.done,
                textDirection: TextDirection.ltr,
                onSubmitted: (_) => _submit(),
                validator: AppValidators.required(l10n.authOtpRequired),
              ),
              Dimens.gapXl,
              _VerifyButton(onPressed: _submit),
              Dimens.gapLg,
              _ResendButton(onPressed: _resend),
            ],
          ),
        ),
      ),
    );
  }
}

class _VerifyButton extends StatelessWidget {
  const _VerifyButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select(
          (AuthCubit c) =>
      c.state.action == AuthAction.verifyEmail &&
          c.state.status == RequestStatus.loading,
    );
    return AppButton(
      label: S.of(context).verifyEmailButton,
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
      c.state.action == AuthAction.resendOtp &&
          c.state.status == RequestStatus.loading,
    );
    return AppTextButton(
      label: S.of(context).verifyEmailResend,
      isLoading: isLoading,
      onPressed: onPressed,
    );
  }
}