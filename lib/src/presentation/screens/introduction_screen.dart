import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:flutter_programming_question_collection/gen/assets.gen.dart';
import 'package:flutter_programming_question_collection/src/presentation/provider/bloc/introduction/introduction_bloc.dart';
import 'package:flutter_programming_question_collection/src/presentation/screens/splash_screen.dart';
import 'package:flutter_programming_question_collection/src/utils/constants/route_names.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({super.key});

  @override
  State<IntroductionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkOnboardingViewed();
    });
  }

  void checkOnboardingViewed() {
    final appBloc = context.read<AppBloc>();
    if (appBloc.state.isOnboardingViewed!) {
      context.go(AppRouteConstant.homeView);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppBloc, AppState>(
      listener: (context, state) {
        if (state.isOnboardingViewed!) {
          context.go(AppRouteConstant.homeView);
        }
      },
      child: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          if (state.loading || state.isOnboardingViewed!) {
            return const SplashScreen();
          }

          return OnBoardingSlider(
            finishButtonStyle: const FinishButtonStyle(),
            onFinish: () async =>
                context.read<AppBloc>().add(AppEvent.set(true)),
            background: introductionIcons(),
            pageBodies: introductionDescriptions,
            headerBackgroundColor: Colors.white,
            totalPage: 2,
            speed: 1.8,
          );
        },
      ),
    );
  }

  List<Widget> introductionIcons() {
    return [
      _IntroductionIconWidget(
          icon: SvgPicture.asset(Assets.introduction.books)),
      _IntroductionIconWidget(
          icon: SvgPicture.asset(Assets.introduction.questions)),
    ];
  }

  List<Widget> get introductionDescriptions {
    return [
      const Padding(
        padding: EdgeInsets.only(top: 350, left: 10, right: 10),
        child: Text('First Page'),
      ),
      const Padding(
          padding: EdgeInsets.only(top: 370, left: 10, right: 10),
          child: Text('Second Page'))
    ];
  }
}

class _IntroductionIconWidget extends StatelessWidget {
  const _IntroductionIconWidget({required this.icon});

  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * .5,
      width: MediaQuery.sizeOf(context).width,
      child: icon,
    );
  }
}
