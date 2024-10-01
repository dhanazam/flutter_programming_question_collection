part of 'introduction_bloc.dart';

class IntroductionState {
  final bool? isOnboardingViewed;
  final bool loading;

  IntroductionState({required this.isOnboardingViewed, required this.loading});

  IntroductionState copyWith({bool? isOnboardingViewed, bool? loading}) {
    return IntroductionState(
      isOnboardingViewed: isOnboardingViewed ?? this.isOnboardingViewed,
      loading: loading ?? this.loading,
    );
  }

  factory IntroductionState.unknown() {
    return IntroductionState(isOnboardingViewed: false, loading: false);
  }
}
