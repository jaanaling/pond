import 'package:core_logic/core_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:pond_care/src/core/utils/app_icon.dart';
import 'package:pond_care/src/core/utils/icon_provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => InitializationCubit()..initialize(),
      child: BlocListener<InitializationCubit, InitializationState>(
        listener: (context, state) {
          if (state is InitializedState) {
            context.go(state.startRoute);
          }
        },
        child: Stack(
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
        ),
      ),
    );
  }
}
