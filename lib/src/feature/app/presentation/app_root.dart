import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:leprecoin/src/feature/chellenge/bloc/challenge_bloc.dart';
import 'package:leprecoin/src/feature/chellenge/models/chellenge.dart';
import 'package:leprecoin/src/feature/goals/bloc/goals_bloc.dart';
import 'package:leprecoin/src/feature/tips/bloc/tips_bloc.dart';
import 'package:leprecoin/src/feature/transaction/bloc/transaction_bloc.dart';

import '../../../../routes/go_router_config.dart';

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TipsBloc()..add(LoadTips()),
        ),
        BlocProvider(
          create: (context) => ChallengeBloc()..add(LoadChallenge()),
        ),
        BlocProvider(create: (context) => GoalsBloc()..add(LoadGoals())),
        BlocProvider(
            create: (context) => TransactionBloc()..add(LoadTransaction())),
      ],
      child: CupertinoApp.router(
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: const CupertinoThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.white,
          textTheme: CupertinoTextThemeData(
            textStyle: TextStyle(
              fontFamily: 'satoshi',
              fontWeight: FontWeight.w400,
              fontSize: 20,
            ),
          ),
        ),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          EasyLocalization.of(context)!.delegate,
        ],
        routerConfig: buildGoRouter,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
