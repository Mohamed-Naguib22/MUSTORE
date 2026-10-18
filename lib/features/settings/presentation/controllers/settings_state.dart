import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mustore/core/error/failure.dart';

class SettingsState extends Equatable {
  const SettingsState({
    this.themeMode = ThemeMode.system,
    this.locale,
    this.failure,
  });

  final ThemeMode themeMode;
  final Locale? locale;
  final Failure? failure;

  SettingsState copyWith({
    ThemeMode? themeMode,
    Locale? locale,
    bool clearLocale = false,
    Failure? failure,
  }) =>
      SettingsState(
        themeMode: themeMode ?? this.themeMode,
        locale: clearLocale ? null : (locale ?? this.locale),
        failure: failure,
      );

  @override
  List<Object?> get props => [themeMode, locale, failure];
}