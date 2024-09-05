import 'package:flutter_programming_question_collection/src/domain/models/book/book_category.dart';
import 'package:flutter_programming_question_collection/src/domain/models/question/question_category.dart';
import 'package:hive/hive.dart';

class CacheService {
  Box get cachedquestions => Hive.box('questions');
  Box<QuestionCategory> get bookmarkedQuestionsCategories =>
      Hive.box('question-categories');
  Box<BookCategory> get bookmarkedBooksCategories =>
      Hive.box('book-categories');
}
