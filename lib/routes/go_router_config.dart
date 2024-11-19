import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pond_care/src/feature/pond/presentation/add_pond_screen.dart';
import 'package:pond_care/src/feature/pond/presentation/home_screen.dart';
import 'package:pond_care/src/feature/splash/presentation/screens/splash_screen.dart';
import 'package:pond_care/routes/root_navigation_screen.dart';
import 'package:pond_care/routes/route_value.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _homeNavigatorKey = GlobalKey<NavigatorState>();
final _goalsNavigatorKey = GlobalKey<NavigatorState>();
final _chellengeNavigatorKey = GlobalKey<NavigatorState>();
final _tipsNavigatorKey = GlobalKey<NavigatorState>();
final _transactionNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

GoRouter buildGoRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: RouteValue.splash.path,
  routes: <RouteBase>[
    StatefulShellRoute.indexedStack(
      pageBuilder: (context, state, navigationShell) {
        return NoTransitionPage(
          child: RootNavigationScreen(
            navigationShell: navigationShell,
          ),
        );
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _homeNavigatorKey,
          routes: <RouteBase>[
            GoRoute(
              parentNavigatorKey: _homeNavigatorKey,
              path: RouteValue.home.path,
              builder: (context, state) => HomeScreen(key: UniqueKey()),
              routes: <RouteBase>[
                GoRoute(
                  parentNavigatorKey: _homeNavigatorKey,
                  path: RouteValue.addPond.path,
                  builder: (context, state) {
                    return ColoredBox(
                      color: Colors.white,
                      child: AddPondScreen(
                        key: UniqueKey(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      pageBuilder: (context, state, child) {
        return NoTransitionPage(
          child: CupertinoPageScaffold(
            backgroundColor: CupertinoColors.black,
            child: child,
          ),
        );
      },
      routes: <RouteBase>[
        GoRoute(
          path: RouteValue.splash.path,
          builder: (BuildContext context, GoRouterState state) {
            return const SplashScreen();
          },
        ),
      ],
    ),
  ],
);
