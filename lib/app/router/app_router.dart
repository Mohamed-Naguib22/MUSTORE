import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mustore/app/app_page.dart';
import 'package:mustore/app/app_page_scaffold.dart';
import 'package:mustore/app/di/injection.dart';
import 'package:mustore/app/router/main_shell.dart';
import 'package:mustore/app/router/screens/not_found_screen.dart';
import 'package:mustore/core/style/dimens/dimens.dart';
import 'package:mustore/core/utils/enums/access_level.dart';
import 'package:mustore/features/auth/domain/enums/auth_status.dart';
import 'package:mustore/features/auth/presentation/controllers/auth_cubit.dart';
import 'package:mustore/features/catalog/presentation/controllers/category/category_cubit.dart';
import 'package:mustore/features/catalog/presentation/controllers/product/product_cubit.dart';
import 'package:mustore/features/home/presentation/controllers/home_cubit.dart';

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
        pageBuilder: (_, state) => CustomTransitionPage(
          key: state.pageKey,
          transitionDuration: Dimens.normal,
          reverseTransitionDuration: Dimens.normal,
          child: AppPageScaffold(page: page, child: _providers(page)),
          transitionsBuilder: (context, animation, secondary, child) =>
              _transition(page, context, animation, secondary, child),
        ),
        routes: routes,
      );

  Widget _providers(AppPage page) {
    final child = page.builder();

    return switch (page) {
      AppPage.home => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => sl<HomeCubit>()),
          BlocProvider(create: (_) => sl<ProductsCubit>()),
          BlocProvider(create: (_) => sl<CategoryCubit>()),
        ],
        child: child,
      ),
      _ => child,
    };
  }

  void dispose() {
    _sub.cancel();
    router.dispose();
    auth.dispose();
  }
}

Widget _transition(
    AppPage page,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondary,
    Widget child,
    ) {
  final enter = animation.drive(CurveTween(curve: Curves.easeOutCubic));
  final exit = secondary.drive(CurveTween(curve: Curves.easeOutCubic));

  if (page == AppPage.splash) {
    return FadeTransition(opacity: enter, child: child);
  }

  if (page.fullScreen) {
    return FadeTransition(
      opacity: enter,
      child: SlideTransition(
        position: enter.drive(
          Tween(begin: const Offset(0, 0.06), end: Offset.zero),
        ),
        child: child,
      ),
    );
  }

  final dx = Directionality.of(context) == TextDirection.rtl ? -1.0 : 1.0;
  return SlideTransition(
    position: exit.drive(
      Tween(begin: Offset.zero, end: Offset(-0.15 * dx, 0)),
    ),
    child: SlideTransition(
      position: enter.drive(
        Tween(begin: Offset(0.25 * dx, 0), end: Offset.zero),
      ),
      child: FadeTransition(opacity: enter, child: child),
    ),
  );
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
      return signedIn ? null : AppPage.signInRequired.path;
  }
}