import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mustore/app/app_page.dart';
import 'package:mustore/core/error/failure_message.dart';
import 'package:mustore/core/utils/enums/request_status.dart';
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

  String _genderLabel(Gender g) =>
      g.name[0].toUpperCase() + g.name.substring(1);

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (_, curr) =>
      curr.action == AuthAction.register &&
          (curr.status == RequestStatus.failure ||
              curr.status == RequestStatus.success),
      listener: (context, state) {
        final messenger = ScaffoldMessenger.of(context)..hideCurrentSnackBar();
        if (state.status == RequestStatus.failure) {
          final message = state.failure?.localizedMessage(context) ?? '';
          if (message.isEmpty) return;
          messenger.showSnackBar(
            SnackBar(content: Text(message), backgroundColor: scheme.error),
          );
        } else {
          // TODO: replace with the verify-email screen once it exists
          messenger.showSnackBar(
            const SnackBar(content: Text('Account created. Please log in.')),
          );
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
                      child: AuthTextField(
                        controller: _firstName,
                        label: 'First name',
                        icon: Icons.person_outline_rounded,
                        keyboardType: TextInputType.name,
                        autofillHints: const [AutofillHints.givenName],
                        validator: (v) =>
                            AuthValidators.required(v, 'Required'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: AuthTextField(
                        controller: _lastName,
                        label: 'Last name',
                        icon: Icons.person_outline_rounded,
                        keyboardType: TextInputType.name,
                        autofillHints: const [AutofillHints.familyName],
                        validator: (v) =>
                            AuthValidators.required(v, 'Required'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                AuthTextField(
                  controller: _email,
                  label: 'Email',
                  icon: Icons.mail_outline_rounded,
                  keyboardType: TextInputType.emailAddress,
                  autofillHints: const [AutofillHints.email],
                  validator: AuthValidators.email,
                ),
                const SizedBox(height: 14),
                AuthTextField(
                  controller: _phone,
                  label: 'Phone number',
                  icon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                  autofillHints: const [AutofillHints.telephoneNumber],
                  validator: (v) =>
                      AuthValidators.required(v, 'Phone number is required'),
                ),
                const SizedBox(height: 14),
                DropdownButtonFormField<Gender>(
                  decoration: authDecoration(
                    context,
                    label: 'Gender',
                    icon: Icons.wc_rounded,
                  ),
                  items: [
                    for (final g in Gender.values)
                      DropdownMenuItem(value: g, child: Text(_genderLabel(g))),
                  ],
                  onChanged: (g) => _gender = g,
                  validator: (g) => g == null ? 'Select your gender' : null,
                ),
                const SizedBox(height: 14),
                PasswordField(
                  controller: _password,
                  autofillHints: const [AutofillHints.newPassword],
                  validator: AuthValidators.password,
                ),
                const SizedBox(height: 14),
                PasswordField(
                  controller: _confirm,
                  label: 'Confirm password',
                  textInputAction: TextInputAction.done,
                  onSubmitted: _submit,
                  validator: (v) =>
                  v == _password.text ? null : 'Passwords do not match',
                ),
                const SizedBox(height: 24),
                _RegisterButton(onPressed: _submit),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: TextStyle(color: scheme.onSurfaceVariant),
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
    return AuthSubmitButton(
      label: 'Create account',
      isLoading: isLoading,
      onPressed: onPressed,
    );
  }
}