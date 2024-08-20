part 'introduction_event.dart';
part 'introduction_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : prefsImpl = AppIntroductionPrefsImpl(),
        super(AppState.unknown()) {
    on<AppEvent>((event, emit) {
      switch (event.type) {
        case AppEvents.startSet:

      }
    });
  }

  void _getState() async {
    emit(state.copyWith(loading: true));
    final isOnboardingViewed = await prefsImpl.getIntroducedState();
    emit(state.copyWith(isOnboardingViewed: isOnboardingViewed, loading: false));
  }

  void _setState(AppEvent event) async {
    emit(state.copyWith(loading: true));
    await prefsImpl.setIntroducedState(event.payload);

    final isOnboardingViewed = await prefsImpl.getIntroducedState();
    emit(state.copyWith(isOnboardingViewed: isOnboardingViewed, loading: false));
  }

  late AppIntroductionPrefsImpl prefsImpl;
}