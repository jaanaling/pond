import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pond_care/src/core/dependency_injection.dart';
import 'package:pond_care/src/feature/app/presentation/app_root.dart';
import 'package:shared_preferences/shared_preferences.dart';

late bool isCreateScreenLoaded;
late bool isEditScreenLoaded;
late bool isOverviewScreenLoaded;
late bool isRecommendationScreenLoaded;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupDependencyInjection();

  final prefs = await SharedPreferences.getInstance();
  isCreateScreenLoaded = prefs.getBool('createScreen') ?? false;
  isEditScreenLoaded = prefs.getBool('editScreen') ?? false;
  isOverviewScreenLoaded = prefs.getBool('overviewScreen') ?? false;
  isRecommendationScreenLoaded = prefs.getBool('recommendationScreen') ?? false;

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    const AppRoot(),
  );
}
