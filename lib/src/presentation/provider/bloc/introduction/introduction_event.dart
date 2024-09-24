part of 'introduction_bloc.dart';

enum IntroductionEvents { startSet, startGet }

class IntroductionEvent {
  IntroductionEvents? type;
  dynamic payload;

  IntroductionEvent.set(bool value) {
    type = IntroductionEvents.startSet;
    payload = value;
  }

  IntroductionEvent.get() {
    type = IntroductionEvents.startGet;
  }
}
