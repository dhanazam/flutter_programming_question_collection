part of 'introduction_bloc.dart';

class AppState {
  final bool? isOnboardingViewed;
  final bool loading;

  AppState({required this.isOnboardingViewed, required this.loading});

  AppState copyWith({bool? isOnboardingViewed, bool? loading}) {
    return AppState(
      isOnboardingViewed: isOnboardingViewed ?? this.isOnboardingViewed,
      loading: loading ?? this.loading,
    );
  }

  factory AppState.unknown() {
    return AppState(isOnboardingViewed: false, loading: false);
  }
}
