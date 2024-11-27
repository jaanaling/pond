import 'dart:async';

import 'package:core_logic/core_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pond_care/routes/route_value.dart';
import 'package:pond_care/src/core/dependency_injection.dart';
import 'package:pond_care/src/feature/app/presentation/app_root.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:core_amplitude/core_amplitude.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

late bool isCreateScreenLoaded;
late bool isEditScreenLoaded;
late bool isOverviewScreenLoaded;
late bool isRecommendationScreenLoaded;

void main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    FlutterError.onError = (FlutterErrorDetails details) {
      _handleFlutterError(details);
    };
    setupDependencyInjection();

    await InitializationUtil.coreInit(
      domain: 'pondcarea.com',
      amplitudeKey: 'ab7fc781165b2ee1db9e5abe0e9412eb',
      appsflyerDevKey: 'iUCiBLKckw4HYFfLnLZ6M6',
      appId: 'com.pioneerbloom.pondcare',
      iosAppId: '6738591800',
      initialRoute: RouteValue.home.path,
      facebookClientToken: '02c9a03dd3a2f6b0399f201d45ab13bc',
      facebookAppId: '590554303357492',
    );

    final prefs = await SharedPreferences.getInstance();
    isCreateScreenLoaded = prefs.getBool('createScreen') ?? false;
    isEditScreenLoaded = prefs.getBool('editScreen') ?? false;
    isOverviewScreenLoaded = prefs.getBool('overviewScreen') ?? false;
    isRecommendationScreenLoaded =
        prefs.getBool('recommendationScreen') ?? false;

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    runApp(
      const AppRoot(),
    );
  }, (Object error, StackTrace stackTrace) {
    _handleAsyncError(error, stackTrace);
  });
}

void _handleFlutterError(FlutterErrorDetails details) {
  AmplitudeUtil.logFailure(
    details.exception is Exception ? Failure.exception : Failure.error,
    details.exception.toString(),
    details.stack,
  );
}

void _handleAsyncError(Object error, StackTrace stackTrace) {
  AmplitudeUtil.logFailure(
    error is Exception ? Failure.exception : Failure.error,
    error.toString(),
    stackTrace,
  );
}
