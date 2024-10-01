import 'package:authentication_repository/authentication_repository.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_programming_question_collection/src/config/hive/hive_config.dart';
import 'package:flutter_programming_question_collection/src/presentation/provider/bloc/app/app_bloc.dart';
import 'package:flutter_programming_question_collection/src/presentation/provider/bloc/category/category_bloc.dart';
import 'package:flutter_programming_question_collection/src/presentation/provider/bloc/feedback/feedback_cubit.dart';
import 'package:flutter_programming_question_collection/src/utils/view_utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_app_check/firebase_app_check.dart';

import 'src/config/router/router_config.dart';
import 'src/presentation/provider/bloc/introduction/introduction_bloc.dart';
import 'src/presentation/provider/bloc/questions/question_bloc.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Firebase.initializeApp();
  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.debug,
  );

  await EasyLocalization.ensureInitialized();

  await dotenv.load(fileName: ".env");

  await HiveConfig.config.init();

  final authenticationRepository = AuthenticationRepository();
  await authenticationRepository.retrieveCurrentUser().first;

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
      child: ProgrammingQuestionCollection(
          authenticationRepository: authenticationRepository),
    ),
  );
}

class ProgrammingQuestionCollection extends StatelessWidget {
  const ProgrammingQuestionCollection(
      {super.key, required authenticationRepository})
      : _authenticationRepository = authenticationRepository;

  final AuthenticationRepository _authenticationRepository;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<IntroductionBloc>(
            create: (context) =>
                IntroductionBloc()..add(IntroductionEvent.get())),
        BlocProvider<QuestionBloc>(create: (context) => QuestionBloc()),
        BlocProvider(create: (context) => FeedbackCubit()),
        BlocProvider(create: (context) => CategoryBloc()),
        BlocProvider(
          create: (context) =>
              AppBloc(authenticationRepository: _authenticationRepository),
        )
      ],
      child: BlocBuilder<IntroductionBloc, IntroductionState>(
        builder: (context, state) {
          if (state.loading) return const SizedBox.shrink();
          return MaterialApp.router(
            title: "Programming Question Collection",
            restorationScopeId: 'interview_helper',
            debugShowCheckedModeBanner: false,
            routerConfig: AppRouterConfig.init.config,
            scaffoldMessengerKey: ViewUtils.scaffoldMessengerKey,
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
