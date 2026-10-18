import 'package:flutter/material.dart';

abstract interface class SettingsLocalDataSource {
  Future<ThemeMode> readTheme();
  Future<void> writeTheme(ThemeMode mode);
  Future<Locale?> readLocale();
  Future<void> writeLocale(Locale? locale);
}