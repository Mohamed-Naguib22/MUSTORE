import 'package:flutter/material.dart';
import 'package:mustore/core/storage/local_storage.dart';
import 'package:mustore/features/settings/data/data_sources/settings_data_source.dart';

class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  const SettingsLocalDataSourceImpl(this._storage);

  final LocalStorage _storage;

  static const _themeKey = 'settings.theme';
  static const _localeKey = 'settings.locale';

  @override
  Future<ThemeMode> readTheme() async {
    final name = await _storage.readString(_themeKey);
    return ThemeMode.values.asNameMap()[name] ?? ThemeMode.system;
  }

  @override
  Future<void> writeTheme(ThemeMode mode) =>
      _storage.writeString(_themeKey, mode.name);

  @override
  Future<Locale?> readLocale() async {
    final code = await _storage.readString(_localeKey);
    return code == null ? null : Locale(code);
  }

  @override
  Future<void> writeLocale(Locale? locale) => locale == null
      ? _storage.delete(_localeKey)
      : _storage.writeString(_localeKey, locale.languageCode);
}