import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mustore/app/app.dart';
import 'package:mustore/app/di/injection.dart';
import 'package:mustore/features/settings/presentation/controllers/settings_cubit.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await configureDependencies();
  await sl<SettingsCubit>().load();

  runApp(const App());
}