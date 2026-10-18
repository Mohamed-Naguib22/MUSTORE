import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mustore/app/app_page.dart';
import 'package:mustore/core/error/failure_message.dart';
import 'package:mustore/core/style/dimens/dimens.dart';
import 'package:mustore/core/utils/enums/request_status.dart';
import 'package:mustore/core/widgets/buttons/app_button.dart';
import 'package:mustore/core/widgets/feedback/app_toast.dart';
import 'package:mustore/core/widgets/inputs/app_dropdown_field.dart';
import 'package:mustore/core/widgets/inputs/app_text_field.dart';
import 'package:mustore/features/auth/presentation/controllers/auth_cubit.dart';
import 'package:mustore/features/auth/presentation/controllers/auth_state.dart';
import 'package:mustore/features/auth/presentation/widgets/auth_scaffold.dart';
import 'package:mustore/features/profile/domain/enums/gender.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _phone = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();
  Gender? _gender;

  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    _phone.dispose();
    _email.dispose();
    _password.dispose();
    _confirm.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    context.read<AuthCubit>().register(
      firstName: _firstName.text.trim(),
      lastName: _lastName.text.trim(),
      phoneNumber: _phone.text.trim(),
      email: _email.text.trim(),
      password: _password.text,
      gender: _gender!,
    );
  }

  void _openLogin() {
    if (context.canPop()) {
      context.pop();
    } else {
      context.goNamed(AppPage.login.name);
    }
  }

  String _genderLabel(Gender g) => g.name[0].toUpperCase() + g.name.substring(1);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (_, curr) =>
      curr.action == AuthAction.register &&
          (curr.status == RequestStatus.failure ||
              curr.status == RequestStatus.success),
      listener: (context, state) {
        if (state.status == RequestStatus.failure) {
          final message = state.failure?.localizedMessage(context) ?? '';
          if (message.isEmpty) return;
          AppToast.error(context, message);
        } else {
          AppToast.success(context, 'Account created. Please log in.');
          _openLogin();
        }
      },
      child: AuthScaffold(
        title: 'Create account',
        subtitle: 'Join MUSTORE and start shopping',
        child: Form(
          key: _formKey,
          child: AutofillGroup(
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: AppTextField(
                        controller: _firstName,
                        label: 'First name',
                        hint: 'Enter your first name',
                        prefixIcon: Icons.person_outline_rounded,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        autofillHints: const [AutofillHints.givenName],
                        validator: (v) => AuthValidators.required(v, 'Required'),
                      ),
                    ),
                    Dimens.gapMd,
                    Expanded(
                      child: AppTextField(
                        controller: _lastName,
                        label: 'Last name',
                        hint: 'Enter your last name',
                        prefixIcon: Icons.person_outline_rounded,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        autofillHints: const [AutofillHints.familyName],
                        validator: (v) => AuthValidators.required(v, 'Required'),
                      ),
                    ),
                  ],
                ),
                Dimens.gapLg,
                AppTextField(
                  controller: _email,
                  label: 'Email',
                  hint: 'name@example.com',
                  prefixIcon: Icons.mail_outline_rounded,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  textDirection: TextDirection.ltr,
                  autofillHints: const [AutofillHints.email],
                  validator: AuthValidators.email,
                ),
                Dimens.gapLg,
                AppTextField(
                  controller: _phone,
                  label: 'Phone number',
                  hint: 'e.g. 01012345678',
                  prefixIcon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  textDirection: TextDirection.ltr,
                  autofillHints: const [AutofillHints.telephoneNumber],
                  validator: (v) => AuthValidators.required(v, 'Phone number is required'),
                ),
                Dimens.gapLg,
                AppDropdownField<Gender>(
                  label: 'Gender',
                  hint: 'Select your gender',
                  prefixIcon: Icons.wc_rounded,
                  items: [
                    for (final g in Gender.values)
                      DropdownMenuItem(value: g, child: Text(_genderLabel(g))),
                  ],
                  onChanged: (g) => _gender = g,
                  validator: (g) => g == null ? 'Select your gender' : null,
                ),
                Dimens.gapLg,
                AppTextField(
                  controller: _password,
                  label: 'Password',
                  hint: 'Create a password',
                  prefixIcon: Icons.lock_outline_rounded,
                  isPassword: true,
                  textInputAction: TextInputAction.next,
                  textDirection: TextDirection.ltr,
                  autofillHints: const [AutofillHints.newPassword],
                  validator: AuthValidators.password,
                ),
                Dimens.gapLg,
                AppTextField(
                  controller: _confirm,
                  label: 'Confirm password',
                  hint: 'Re-enter your password',
                  prefixIcon: Icons.lock_outline_rounded,
                  isPassword: true,
                  textInputAction: TextInputAction.done,
                  textDirection: TextDirection.ltr,
                  onSubmitted: (_) => _submit(),
                  validator: (v) => v == _password.text ? null : 'Passwords do not match',
                ),
                Dimens.gapXl,
                _RegisterButton(onPressed: _submit),
                Dimens.gapXl,
                Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    TextButton(
                      onPressed: _openLogin,
                      child: const Text('Log in'),
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

class _RegisterButton extends StatelessWidget {
  const _RegisterButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select(
          (AuthCubit c) =>
      c.state.action == AuthAction.register &&
          c.state.status == RequestStatus.loading,
    );
    return AppButton(
      label: 'Create account',
      isLoading: isLoading,
      onPressed: onPressed,
    );
  }
}