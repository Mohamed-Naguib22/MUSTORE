import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mustore/app/app_page.dart';
import 'package:mustore/app/app_page_scaffold.dart';
import 'package:mustore/app/router/main_shell.dart';
import 'package:mustore/app/router/screens/not_found_screen.dart';
import 'package:mustore/core/utils/enums/access_level.dart';
import 'package:mustore/features/auth/domain/enums/auth_status.dart';
import 'package:mustore/features/auth/presentation/controllers/auth_cubit.dart';

class AppRouter {
  AppRouter(AuthCubit authCubit)
      : auth = ValueNotifier(authCubit.state.authStatus) {
    _sub = authCubit.stream
        .map((s) => s.authStatus)
        .distinct()
        .listen((status) => auth.value = status);
  }

  final ValueNotifier<AuthStatus> auth;
  late final StreamSubscription<AuthStatus> _sub;
  final _rootKey = GlobalKey<NavigatorState>();

  late final GoRouter router = GoRouter(
    navigatorKey: _rootKey,
    refreshListenable: auth,
    redirect: (_, state) => _redirect(auth.value, state.uri),
    errorBuilder: (_, _) => const NotFoundScreen(),
    routes: [
      ..._routesOf(null),
      StatefulShellRoute.indexedStack(
        builder: (_, _, shell) => MainShell(navigationShell: shell),
        branches: [
          for (final tab in AppPage.tabs)
            StatefulShellBranch(routes: [
              _route(tab, routes: _routesOf(tab)),
            ]),
        ],
      ),
    ],
  );

  List<RouteBase> _routesOf(AppPage? parent) => [
    for (final p in AppPage.values)
      if (p.parent == parent && !p.isTab) _route(p, routes: _routesOf(p)),
  ];

  GoRoute _route(AppPage page, {List<RouteBase> routes = const []}) =>
      GoRoute(
        path: page.localPath,
        name: page.name,
        parentNavigatorKey: page.fullScreen ? _rootKey : null,
        builder: (_, _) => AppPageScaffold(page: page, child: page.builder()),
        routes: routes,
      );

  void dispose() {
    _sub.cancel();
    router.dispose();
    auth.dispose();
  }
}

String? _redirect(AuthStatus auth, Uri uri) {
  final page = AppPage.match(uri.path);

  if (auth == AuthStatus.unknown) {
    return page == AppPage.splash ? null : AppPage.splash.path;
  }

  if (page == AppPage.splash) return AppPage.home.path;

  final signedIn = auth == AuthStatus.authenticated;
  switch (page?.access ?? AccessLevel.public) {
    case AccessLevel.public:
      return null;
    case AccessLevel.guestOnly:
      return signedIn ? AppPage.home.path : null;
    case AccessLevel.authenticated:
      return signedIn ? null : AppPage.login.path;
  }
}