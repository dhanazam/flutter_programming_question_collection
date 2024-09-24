// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_programming_question_collection/src/data/datasources/local/application_prefs.dart';

part 'introduction_event.dart';
part 'introduction_state.dart';

class IntroductionBloc extends Bloc<IntroductionEvent, IntroductionState> {
  IntroductionBloc()
      : prefsImpl = AppIntroductionPrefsImpl(),
        super(IntroductionState.unknown()) {
    on<IntroductionEvent>((event, emit) {
      switch (event.type) {
        case IntroductionEvents.startSet:
          _setState(event);
          break;
        case IntroductionEvents.startGet:
          _getState();
        default:
      }
    });
  }

  void _getState() async {
    emit(state.copyWith(loading: true));
    final isOnboardingViewed = await prefsImpl.getIntroducedState();
    emit(
        state.copyWith(isOnboardingViewed: isOnboardingViewed, loading: false));
  }

  void _setState(IntroductionEvent event) async {
    emit(state.copyWith(loading: true));
    await prefsImpl.setIntroducedState(event.payload);

    final isOnboardingViewed = await prefsImpl.getIntroducedState();
    emit(
        state.copyWith(isOnboardingViewed: isOnboardingViewed, loading: false));
  }

  late AppIntroductionPrefsImpl prefsImpl;
}
