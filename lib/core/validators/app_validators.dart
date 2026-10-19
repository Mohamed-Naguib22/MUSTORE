import 'package:flutter/material.dart';
import 'package:mustore/generated/l10n.dart';

abstract final class AppValidators {
  static const _minPasswordLength = 8;
  static final _email = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  static FormFieldValidator<String> required(String message) =>
          (v) => (v == null || v.trim().isEmpty) ? message : null;

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