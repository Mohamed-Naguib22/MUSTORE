import 'dart:ui' show PlatformDispatcher;
import 'package:mustore/core/services/localization/language_provider.dart';
import 'package:mustore/features/settings/presentation/controllers/settings_cubit.dart';

class SettingsLanguageProvider implements LanguageProvider {
  const SettingsLanguageProvider(this._settingsCubit);

  final SettingsCubit _settingsCubit;

  @override
  String get languageCode =>
      (_settingsCubit.state.locale ?? PlatformDispatcher.instance.locale)
          .languageCode;
}