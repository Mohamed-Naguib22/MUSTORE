import 'package:get_it/get_it.dart';
import 'package:mustore/app/router/app_router.dart';
import 'package:mustore/features/auth/presentation/controllers/auth_cubit.dart';

Future<void> registerAppModule(GetIt sl) async {
  sl.registerLazySingleton<AppRouter>(() => AppRouter(sl<AuthCubit>()),
    dispose: (r) => r.dispose(),
  );
}