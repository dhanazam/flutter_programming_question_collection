import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_programming_question_collection/src/config/hive/hive_config.dart';

import 'src/config/router/router_config.dart';
import 'src/presentation/provider/bloc/introduction/introduction_bloc.dart';
import 'src/presentation/provider/bloc/questions/question_bloc.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await EasyLocalization.ensureInitialized();

  await HiveConfig.config.init();

  FlutterNativeSplash.remove();
  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en', ''),
        Locale('tr', ''),
        Locale('ru', ''),
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('en', ''),
      child: const ProgrammingQuestionCollection(),
    ),
  );
}

class ProgrammingQuestionCollection extends StatelessWidget {
  const ProgrammingQuestionCollection({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppBloc>(
          create: (context) => AppBloc()..add(AppEvent.get()),
        ),
        BlocProvider<QuestionBloc>(
          create: (context) => QuestionBloc(),
        )
      ],
      child: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          if (state.loading) return const SizedBox.shrink();
          return MaterialApp.router(
            title: "Programming Question Collection",
            restorationScopeId: 'interview_helper',
            debugShowCheckedModeBanner: false,
            routerConfig: AppRouterConfig.init.config,
            locale: !state.isOnboardingViewed!
                ? View.of(context).platformDispatcher.locale
                : context.locale,
            supportedLocales: context.supportedLocales,
            localizationsDelegates: context.localizationDelegates,
          );
        },
      ),
    );
  }
}
