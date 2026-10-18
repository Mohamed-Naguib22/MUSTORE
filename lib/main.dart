import 'package:flutter/material.dart';
import 'package:mustore/app/app.dart';
import 'package:mustore/app/di/injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await configureDependencies();

  runApp(const App());
}