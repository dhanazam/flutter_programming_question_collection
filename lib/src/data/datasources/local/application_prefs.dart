import 'package:shared_preferences/shared_preferences.dart';

abstract class AppIntroductionPrefs {
  Future<bool> getIntroducedState();
  Future<void> setIntroducedState(bool value);
}

class AppIntroductionPrefsImpl implements AppIntroductionPrefs {
  AppIntroductionPrefsImpl()
      : _applicationPrefs = SharedPreferences.getInstance();

  final Future<SharedPreferences> _applicationPrefs;

  @override
  Future<bool> getIntroducedState() async {
    final introduced = (await _applicationPrefs).getBool('introduced');
    return introduced ?? false;
  }

  @override
  Future<void> setIntroducedState(bool value) async {
    (await _applicationPrefs).setBool('introduced', value);
  }
}
