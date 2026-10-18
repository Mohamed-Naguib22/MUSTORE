import 'package:flutter/material.dart';

class AuthScaffold extends StatelessWidget {
  const AuthScaffold({
    super.key,
    required this.title,
    required this.subtitle,
    required this.child,
  });

  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 56,
                    width: 56,
                    decoration: BoxDecoration(
                      color: scheme.primary,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      Icons.shopping_bag_rounded,
                      color: scheme.onPrimary,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    title,
                    style: text.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    style: text.bodyMedium?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 28),
                  child,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

InputDecoration authDecoration(
    BuildContext context, {
      required String label,
      required IconData icon,
      Widget? suffix,
    }) {
  final scheme = Theme.of(context).colorScheme;
  OutlineInputBorder border(Color color, [double width = 1]) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: color, width: width),
      );

  return InputDecoration(
    labelText: label,
    prefixIcon: Icon(icon),
    suffixIcon: suffix,
    filled: true,
    fillColor: scheme.surfaceContainerHighest,
    enabledBorder: border(Colors.transparent),
    focusedBorder: border(scheme.primary, 1.5),
    errorBorder: border(scheme.error),
    focusedErrorBorder: border(scheme.error, 1.5),
  );
}

class AuthTextField extends StatelessWidget {
  const AuthTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    this.validator,
    this.keyboardType,
    this.textInputAction = TextInputAction.next,
    this.autofillHints,
  });

  final TextEditingController controller;
  final String label;
  final IconData icon;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final TextInputAction textInputAction;
  final Iterable<String>? autofillHints;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      autofillHints: autofillHints,
      decoration: authDecoration(context, label: label, icon: icon),
    );
  }
}

class PasswordField extends StatefulWidget {
  const PasswordField({
    super.key,
    required this.controller,
    this.label = 'Password',
    this.validator,
    this.textInputAction = TextInputAction.next,
    this.onSubmitted,
    this.autofillHints,
  });

  final TextEditingController controller;
  final String label;
  final String? Function(String?)? validator;
  final TextInputAction textInputAction;
  final VoidCallback? onSubmitted;
  final Iterable<String>? autofillHints;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  final _obscure = ValueNotifier<bool>(true);

  @override
  void dispose() {
    _obscure.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _obscure,
      builder: (_, obscure, __) => TextFormField(
        controller: widget.controller,
        validator: widget.validator,
        obscureText: obscure,
        textInputAction: widget.textInputAction,
        autofillHints: widget.autofillHints,
        onFieldSubmitted: (_) => widget.onSubmitted?.call(),
        decoration: authDecoration(
          context,
          label: widget.label,
          icon: Icons.lock_outline_rounded,
          suffix: IconButton(
            onPressed: () => _obscure.value = !obscure,
            icon: Icon(
              obscure
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
            ),
          ),
        ),
      ),
    );
  }
}

class AuthSubmitButton extends StatelessWidget {
  const AuthSubmitButton({
    super.key,
    required this.label,
    required this.isLoading,
    required this.onPressed,
  });

  final String label;
  final bool isLoading;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: FilledButton(
        onPressed: isLoading ? null : onPressed,
        style: FilledButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: isLoading
            ? const SizedBox(
          height: 22,
          width: 22,
          child: CircularProgressIndicator(strokeWidth: 2.5),
        )
            : Text(label),
      ),
    );
  }
}

abstract final class AuthValidators {
  static final _email = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  static String? required(String? v, String message) =>
      (v == null || v.trim().isEmpty) ? message : null;

  static String? email(String? v) {
    if (v == null || v.trim().isEmpty) return 'Email is required';
    return _email.hasMatch(v.trim()) ? null : 'Enter a valid email';
  }

  static String? password(String? v) {
    if (v == null || v.isEmpty) return 'Password is required';
    return v.length < 8 ? 'At least 8 characters' : null;
  }
}