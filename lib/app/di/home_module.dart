import 'package:get_it/get_it.dart';
import 'package:mustore/features/home/presentation/controllers/home_cubit.dart';

void registerHomeModule(GetIt sl) {


  sl.registerLazySingleton(() => HomeCubit(
    locationService: sl(),
  ));
}