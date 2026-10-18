import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mustore/app/app_page.dart';
import 'package:mustore/core/error/failure_message.dart';
import 'package:mustore/core/utils/enums/request_status.dart';
import 'package:mustore/features/auth/presentation/controllers/auth_cubit.dart';
import 'package:mustore/features/auth/presentation/controllers/auth_state.dart';
import 'package:mustore/features/auth/presentation/widgets/auth_scaffold.dart';

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
    final from = GoRouterState.of(context).uri.queryParameters['from'];
    context.pushNamed(
      AppPage.register.name,
      queryParameters: {if (from != null) 'from': from},
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (_, curr) =>
      curr.action == AuthAction.login &&
          curr.status == RequestStatus.failure,
      listener: (context, state) {
        final message = state.failure?.localizedMessage(context) ?? '';
        if (message.isEmpty) return;
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(content: Text(message), backgroundColor: scheme.error),
          );
      },
      child: AuthScaffold(
        title: 'Welcome back',
        subtitle: 'Log in to continue shopping',
        child: Form(
          key: _formKey,
          child: AutofillGroup(
            child: Column(
              children: [
                AuthTextField(
                  controller: _email,
                  label: 'Email',
                  icon: Icons.mail_outline_rounded,
                  keyboardType: TextInputType.emailAddress,
                  autofillHints: const [AutofillHints.email],
                  validator: AuthValidators.email,
                ),
                const SizedBox(height: 14),
                PasswordField(
                  controller: _password,
                  textInputAction: TextInputAction.done,
                  autofillHints: const [AutofillHints.password],
                  onSubmitted: _submit,
                  validator: (v) => AuthValidators.required(
                    v,
                    'Password is required',
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text('Forgot password?'),
                  ),
                ),
                const SizedBox(height: 8),
                _LoginButton(onPressed: _submit),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(color: scheme.onSurfaceVariant),
                    ),
                    TextButton(
                      onPressed: _openRegister,
                      child: const Text('Sign up'),
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
    return AuthSubmitButton(
      label: 'Log in',
      isLoading: isLoading,
      onPressed: onPressed,
    );
  }
}