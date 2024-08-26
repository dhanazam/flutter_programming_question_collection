import 'package:flutter_programming_question_collection/src/domain/models/question/question.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as path;

class HiveConfig {
  HiveConfig._();

  static final HiveConfig _config = HiveConfig._();
  static HiveConfig get config => _config;

  Future<void> init() async {
    final dir = await path.getApplicationCacheDirectory();
    await Hive.initFlutter(dir.path);

    _registerAdapters();
  }

  void _registerAdapters() {
    if (!Hive.isAdapterRegistered(3)) {
      Hive.registerAdapter(QuestionAdapter());
    }
  }
}
