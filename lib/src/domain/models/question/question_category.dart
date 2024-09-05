import 'package:flutter_programming_question_collection/src/domain/models/index.dart';
import 'package:hive/hive.dart';

@HiveType(typeId: 2)
class QuestionCategory {
  @HiveField(0)
  final String? name;
  @HiveField(1)
  final List<Question>? questions;

  QuestionCategory({
    required this.name,
    required this.questions,
  });

  void addQuestion(Question question) async {
    if (!questions!.any((q) => q.question == question.question)) {
      questions!.add(question);
    }
  }

  void removeQuestion(Question question) {
    questions!.removeWhere((q) => q.question == question.question);
  }
}
