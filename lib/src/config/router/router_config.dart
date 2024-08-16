import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/screens/introduction_screen.dart';
import '../../utils/constants/route_names.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _homeNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _libraryNavigatorKey =
    GlobalKey<NavigatorState>();

class AppRouterConfig {
  AppRouterConfig._();

  static final AppRouterConfig _init = AppRouterConfig._();
  static AppRouterConfig get init => _init;

  final GoRouter config = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: AppRouterConstant.onboarding,
        name: AppRouterConstant.onboarding,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return NoTransitionPage(
              child: IntroductionScreen(key: state.pageKey));
        },
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, body) {
          return AppScaffold(key: state.pageKey, body: body);
        },
      )
    ],
  );
}
