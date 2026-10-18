import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mustore/core/use_case/use_case.dart';
import 'package:mustore/core/utils/mixins/safe_emit_mixin.dart';
import 'package:mustore/features/settings/domain/use_cases/get_locale_use_case.dart';
import 'package:mustore/features/settings/domain/use_cases/get_theme_mode_use_case.dart';
import 'package:mustore/features/settings/domain/use_cases/set_locale_use_case.dart';
import 'package:mustore/features/settings/domain/use_cases/set_theme_mode_use_case.dart';
import 'package:mustore/features/settings/presentation/controllers/settings_state.dart';

class SettingsCubit extends Cubit<SettingsState>
    with SafeEmitMixin<SettingsState> {
  SettingsCubit({
    required GetThemeModeUseCase getThemeMode,
    required SetThemeModeUseCase setThemeMode,
    required GetLocaleUseCase getLocale,
    required SetLocaleUseCase setLocale,
  })  : _getThemeMode = getThemeMode,
        _setThemeMode = setThemeMode,
        _getLocale = getLocale,
        _setLocale = setLocale,
        super(const SettingsState());

  final GetThemeModeUseCase _getThemeMode;
  final SetThemeModeUseCase _setThemeMode;
  final GetLocaleUseCase _getLocale;
  final SetLocaleUseCase _setLocale;

  Future<void> load() async {
    final theme = await _getThemeMode(const NoParams());
    final locale = await _getLocale(const NoParams());

    safeEmit(
      SettingsState(
        themeMode: theme.fold((_) => ThemeMode.system, (m) => m),
        locale: locale.fold((_) => null, (l) => l),
      ),
    );
  }

  Future<void> changeTheme(ThemeMode mode) async {
    if (mode == state.themeMode) return;
    final previous = state.themeMode;

    safeEmit(state.copyWith(themeMode: mode));

    final result = await _setThemeMode(mode);
    safeFoldSideEffect(
      result,
      onLeft: (f) => safeEmit(state.copyWith(themeMode: previous, failure: f)),
      onRight: (_) {},
    );
  }

  Future<void> changeLocale(Locale? locale) async {
    if (locale == state.locale) return;
    final previous = state.locale;

    safeEmit(state.copyWith(locale: locale, clearLocale: locale == null));

    final result = await _setLocale(locale);
    safeFoldSideEffect(
      result,
      onLeft: (f) => safeEmit(
        state.copyWith(
          locale: previous,
          clearLocale: previous == null,
          failure: f,
        ),
      ),
      onRight: (_) {},
    );
  }
}