import 'package:get_it/get_it.dart';
import 'package:mustore/app/di/app_module.dart';
import 'package:mustore/app/di/auth_module.dart';
import 'package:mustore/app/di/catalog_module.dart';
import 'package:mustore/app/di/core_module.dart';
import 'package:mustore/app/di/home_module.dart';
import 'package:mustore/app/di/settings_module.dart';

final sl = GetIt.instance;

Future<void> configureDependencies() async {
  await registerCoreModule(sl);
  registerAuthModule(sl);
  registerAppModule(sl);
  registerSettingsModule(sl);
  registerCatalogModule(sl);
  registerHomeModule(sl);
}