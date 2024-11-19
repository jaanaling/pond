import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:go_router/go_router.dart';

import '../../../../../routes/route_value.dart';
import '../../../../core/utils/app_icon.dart';
import '../../../../core/utils/icon_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    startLoading(context);
  }

  Future<void> startLoading(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    //
    // // final adId = await AdvertisingId.id(true);
    // // FirebaseMessaging instance = FirebaseMessaging.instance;
    // // final settings =
    // //     await instance.requestPermission(alert: true, badge: true, sound: true);
    // // if (settings.authorizationStatus != AuthorizationStatus.authorized) {
    // //   SharedPreferences.getInstance()
    // //       .then((prefs) => prefs.setBool('notificationsEnabled', false));
    // // }
    //
    context.go(RouteValue.home.path);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned.fill(
          child: AppIcon(
            asset: IconProvider.splash.buildImageUrl(),
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: height * 0.122,
          child: AppIcon(asset: IconProvider.logo.buildImageUrl()),
        ),
        Positioned(
          bottom: height * 0.122,
          child: const SpinKitFadingCircle(
            color: Colors.white,
            size: 98,
          ),
        ),
      ],
    );
  }
}
