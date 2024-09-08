// ignore_for_file: invalid_use_of_visible_for_testing_member
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_programming_question_collection/src/data/datasources/local/base/base_cache_service.dart';
import 'package:flutter_programming_question_collection/src/data/datasources/local/bookmarked_books_source_data.dart';
import 'package:flutter_programming_question_collection/src/data/datasources/local/bookmarked_questions_source_data.dart';
import 'package:flutter_programming_question_collection/src/domain/models/book/book_category.dart';
import 'package:flutter_programming_question_collection/src/domain/models/index.dart';
import 'package:flutter_programming_question_collection/src/domain/models/question/question_category.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc()
      : _bookmarkedQuestionsSourceDataImpl =
            BookmarkedQuestionsSourceDataImpl(),
        _bookmarkedBooksSourceDataImpl = BookmarkedBooksSourceDataImpl(),
        super(CategoryState.unknown()) {
    on<CategoryEvent>((event, emit) {
      switch (event.type) {
        case CategoryEvents.bookmarkQuestionInitial:
          _onBookmarkQuestionInitial(event);
          break;
        case CategoryEvents.removeBookmarkedQuestion:
          _onRemoveBookmarkedQuestion(event);
          break;
        default:
      }
    });
  }

  void _onBookmarkQuestionInitial(CategoryEvent event) async {
    debugPrint('Bookmarking question');
    var category =
        CacheService().bookmarkedQuestionsCategories.get(event.payload);

    if (category == null) {
      category = QuestionCategory(name: event.payload, questions: []);
      category.addQuestion(event.question!);
    } else {
      category.addQuestion(event.question!);
    }

    await CacheService()
        .bookmarkedQuestionsCategories
        .put(event.payload, category);
    final questions = await _bookmarkedQuestionsSourceDataImpl
        .getBookmarkedQuestionsByCategory(event.payload);

    emit(state.copyWith(
      loading: false,
      questions: questions,
      event: CategoryEvents.fetchBookmarkedQuestionsForCategory,
    ));
  }

  void _onRemoveBookmarkedQuestion(CategoryEvent event) async {
    var category =
        CacheService().bookmarkedQuestionsCategories.get(event.payload);

    if (category != null) {
      category.removeQuestion(event.question!);

      await CacheService()
          .bookmarkedQuestionsCategories
          .put(event.payload, category);
      final questions = await _bookmarkedQuestionsSourceDataImpl
          .getBookmarkedQuestionsByCategory(event.payload);

      emit(
        state.copyWith(
          loading: false,
          questions: questions,
          event: CategoryEvents.fetchBookmarkedQuestionsForCategory,
        ),
      );
    }
  }

  late final BookmarkedQuestionsSourceDataImpl
      _bookmarkedQuestionsSourceDataImpl;
  late final BookmarkedBooksSourceDataImpl _bookmarkedBooksSourceDataImpl;
}
