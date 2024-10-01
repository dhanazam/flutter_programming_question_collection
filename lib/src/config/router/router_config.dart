import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_programming_question_collection/src/domain/models/index.dart';
import 'package:flutter_programming_question_collection/src/presentation/provider/bloc/app/app_bloc.dart';
import 'package:flutter_programming_question_collection/src/presentation/provider/bloc/introduction/introduction_bloc.dart';
import 'package:flutter_programming_question_collection/src/presentation/screens/authentication_screen/login_screen.dart';
import 'package:flutter_programming_question_collection/src/presentation/screens/home_screen/bookmark_view.dart';
import 'package:flutter_programming_question_collection/src/presentation/screens/home_screen/index.dart';
import 'package:flutter_programming_question_collection/src/presentation/screens/home_screen/question_screen.dart';
import 'package:flutter_programming_question_collection/src/presentation/screens/library_screen/library_screen.dart';
import 'package:go_router/go_router.dart';

import '../../../app_scaffold.dart';
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
        path: AppRouteConstant.onboarding,
        name: AppRouteConstant.onboarding,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return NoTransitionPage(
              child: IntroductionScreen(key: state.pageKey));
        },
      ),
      GoRoute(
        path: AppRouteConstant.loginView,
        name: AppRouteConstant.loginView,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return NoTransitionPage(
            child: LoginScreen(key: state.pageKey),
          );
        },
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, body) {
          return AppScaffold(key: state.pageKey, body: body);
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: _homeNavigatorKey,
            routes: [
              GoRoute(
                path: AppRouteConstant.homeView,
                name: AppRouteConstant.homeView,
                pageBuilder: (BuildContext context, GoRouterState state) {
                  return NoTransitionPage(
                    child: HomeScreen(key: state.pageKey),
                  );
                },
                routes: [
                  GoRoute(
                    parentNavigatorKey: _rootNavigatorKey,
                    path: AppRouteConstant.questionsView,
                    name: AppRouteConstant.questionsView,
                    pageBuilder: (BuildContext context, GoRouterState state) {
                      final questions = (state.extra as List).cast<Question>();
                      final category = state.uri.queryParameters['category']!;
                      return MaterialPage(
                        child: QuestionsScreen(
                          key: state.pageKey,
                          questions: questions,
                          category: category,
                        ),
                      );
                    },
                    routes: [
                      GoRoute(
                        parentNavigatorKey: _rootNavigatorKey,
                        path: AppRouteConstant.questionView,
                        name: AppRouteConstant.questionView,
                        pageBuilder:
                            (BuildContext context, GoRouterState state) {
                          final questions =
                              (state.extra as List).cast<Question>();
                          final index =
                              int.parse(state.uri.queryParameters['index']!);
                          final category =
                              state.uri.queryParameters['category']!;
                          return MaterialPage(
                            child: QuestionScreen(
                              key: state.pageKey,
                              questions: questions,
                              category: category,
                              index: index,
                            ),
                          );
                        },
                      )
                    ],
                  ),
                  GoRoute(
                    parentNavigatorKey: _rootNavigatorKey,
                    path: AppRouteConstant.bookmark,
                    name: AppRouteConstant.bookmark,
                    pageBuilder: (BuildContext context, GoRouterState state) {
                      return MaterialPage(
                        child: BookmarkView(key: state.pageKey),
                      );
                    },
                  )
                ],
              )
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _libraryNavigatorKey,
            routes: [
              GoRoute(
                path: AppRouteConstant.libraryView,
                name: AppRouteConstant.libraryView,
                pageBuilder: (BuildContext context, GoRouterState state) {
                  return NoTransitionPage(
                    child: LibraryScreen(key: state.pageKey),
                  );
                },
              )
            ],
          ),
        ],
      )
    ],
    redirect: (context, state) {
      final statusAuthentication = context.read<AppBloc>().state.status;
      final statusOnboarding =
          context.read<IntroductionBloc>().state.isOnboardingViewed!;

      debugPrint("statusOnboarding $statusOnboarding");

      if (statusOnboarding) {
        if (statusAuthentication == AppStatus.authenticated) {
          return AppRouteConstant.homeView;
        } else {
          return AppRouteConstant.loginView;
        }
      } else {
        debugPrint("statusOnboarding called");
        return AppRouteConstant.onboarding;
      }
    },
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRouteConstant.onboarding,
  );
}
