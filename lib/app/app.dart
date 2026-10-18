import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mustore/app/di/injection.dart';
import 'package:mustore/app/router/app_router.dart';
import 'package:mustore/core/style/colors/app_theme.dart';
import 'package:mustore/features/auth/presentation/controllers/auth_cubit.dart';
import 'package:mustore/generated/l10n.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>.value(value: sl<AuthCubit>()),
      ],
      child: MaterialApp.router(
        onGenerateTitle: (context) => S.of(context).appTitle,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: ThemeMode.system,
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        routerConfig: sl<AppRouter>().router,
      ),
    );
  }
}