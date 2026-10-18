import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:mustore/app/router/screens/not_found_screen.dart';
import 'package:mustore/features/auth/domain/enums/auth_status.dart';
import 'package:mustore/features/auth/presentation/controllers/auth_cubit.dart';
import 'package:mustore/features/auth/presentation/screens/login_screen.dart';
import 'package:mustore/features/auth/presentation/screens/register_screen.dart';
import 'package:mustore/features/home/presentation/screens/home_screen.dart';
import 'package:mustore/app/router/screens/splash_screen.dart';
import 'access_level.dart';
import 'app_page.dart';

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

  late final GoRouter router = GoRouter(
    refreshListenable: auth,
    redirect: (_, state) => _redirect(auth.value, state.uri),
    errorBuilder: (_, _) => const NotFoundScreen(),
    routes: [
      _route(AppPage.splash, (_, _) => const SplashScreen()),
      _route(AppPage.login, (_, _) => const LoginScreen()),
      _route(AppPage.register, (_, _) => const RegisterScreen()),
      _route(AppPage.home, (_, _) => const HomeScreen()),
    ],
  );

  void dispose() {
    _sub.cancel();
    router.dispose();
    auth.dispose();
  }
}

GoRoute _route(AppPage page, GoRouterWidgetBuilder builder) =>
    GoRoute(path: page.path, name: page.name, builder: builder);

String? _redirect(AuthStatus auth, Uri uri) {
  final page = AppPage.match(uri.path);

  if (auth == AuthStatus.unknown) {
    return page == AppPage.splash ? null : _withFrom(AppPage.splash, uri);
  }

  if (page == AppPage.splash) return _destination(uri);

  final signedIn = auth == AuthStatus.authenticated;
  switch (page?.access ?? AccessLevel.public) {
    case AccessLevel.public:
      return null;
    case AccessLevel.guestOnly:
      return signedIn ? _destination(uri) : null;
    case AccessLevel.authenticated:
      return signedIn ? null : _withFrom(AppPage.login, uri);
  }
}

String _withFrom(AppPage to, Uri uri) {
  final target = uri.toString();
  if (target == '/' || !_isSafe(target)) return to.path;
  return '${to.path}?from=${Uri.encodeQueryComponent(target)}';
}

String _destination(Uri uri) {
  final from = uri.queryParameters['from'];
  return from != null && _isSafe(from) ? from : AppPage.home.path;
}

bool _isSafe(String target) {
  if (!target.startsWith('/') || target.startsWith('//')) return false;
  final page = AppPage.match(Uri.tryParse(target)?.path ?? '');
  return page != null && !page.isAuthFlow;
}