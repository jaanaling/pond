import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pond_care/src/core/dependency_injection.dart';
import 'package:pond_care/src/feature/app/presentation/app_root.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupDependencyInjection();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    const AppRoot(),
  );
}
