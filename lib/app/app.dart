import 'dart:ui' show PlatformDispatcher;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mustore/app/di/injection.dart';
import 'package:mustore/app/router/app_router.dart';
import 'package:mustore/core/services/localization/language_codes.dart';
import 'package:mustore/core/style/colors/app_theme.dart';
import 'package:mustore/features/auth/presentation/controllers/auth_cubit.dart';
import 'package:mustore/features/settings/presentation/controllers/settings_cubit.dart';
import 'package:mustore/features/settings/presentation/controllers/settings_state.dart';
import 'package:mustore/generated/l10n.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>.value(value: sl<AuthCubit>()),
        BlocProvider<SettingsCubit>.value(value: sl<SettingsCubit>()),
      ],
      child: BlocListener<SettingsCubit, SettingsState>(
        listenWhen: (p, c) => p.locale != c.locale,
        listener: (_, _) => sl<AppRouter>().reload(),
        child: BlocBuilder<SettingsCubit, SettingsState>(
          buildWhen: (p, c) =>
          p.themeMode != c.themeMode || p.locale != c.locale,
          builder: (context, settings) {
            final locale =
                settings.locale ?? PlatformDispatcher.instance.locale;
            final isArabic = locale.languageCode == LanguageCodes.ar;

            return MaterialApp.router(
              onGenerateTitle: (context) => S.of(context).appTitle,
              debugShowCheckedModeBanner: false,
              theme: AppTheme.light(isArabic: isArabic),
              darkTheme: AppTheme.dark(isArabic: isArabic),
              themeMode: settings.themeMode,
              locale: settings.locale,
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
              routerConfig: sl<AppRouter>().router,
            );
          },
        ),
      ),
    );
  }
}