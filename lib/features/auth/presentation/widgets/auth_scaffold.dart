import 'package:flutter/material.dart';
import 'package:mustore/core/style/dimens/dimens.dart';
import 'package:mustore/generated/l10n.dart';

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
            padding: const EdgeInsetsDirectional.all(Dimens.xl),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: text.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Dimens.gapXs,
                  Text(
                    subtitle,
                    style: text.bodyMedium?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                  Dimens.gapXl,
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

abstract final class AuthValidators {
  static const _minPasswordLength = 8;
  static final _email = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  static String? required(String? v, String message) =>
      (v == null || v.trim().isEmpty) ? message : null;

  static FormFieldValidator<String> email(S l10n) => (v) {
    if (v == null || v.trim().isEmpty) return l10n.authEmailRequired;
    return _email.hasMatch(v.trim()) ? null : l10n.authEmailInvalid;
  };

  static FormFieldValidator<String> password(S l10n) => (v) {
    if (v == null || v.isEmpty) return l10n.authPasswordRequired;
    return v.length < _minPasswordLength
        ? l10n.authPasswordTooShort(_minPasswordLength)
        : null;
  };
}