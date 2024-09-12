// ignore_for_file: invalid_use_of_visible_for_testing_member
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
        case CategoryEvents.fetchBookmarkedQuestionsForCategory:
          _onFetchBookmarkedQuestionsForCategory(event);
          break;
        default:
      }
    });
  }

  void _onBookmarkQuestionInitial(CategoryEvent event) async {
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

    emit(
      state.copyWith(
        loading: false,
        questions: questions,
        event: CategoryEvents.fetchBookmarkedQuestionsForCategory,
      ),
    );
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

  void _onFetchBookmarkedQuestionsForCategory(CategoryEvent event) async {
    emit(state.copyWith(loading: true));

    try {
      final bookmarkedQuestions = await _bookmarkedQuestionsSourceDataImpl
          .getBookmarkedQuestionsByCategory(event.payload);

      emit(
        state.copyWith(
          loading: false,
          questions: bookmarkedQuestions,
          event: CategoryEvents.fetchBookmarkedQuestionsForCategory,
        ),
      );
    } catch (exp) {
      emit(
        state.copyWith(
          questions: [],
          loading: true,
          event: CategoryEvents.fetchBookmarkedQuestionsForCategoryError,
          error: ExceptionModel(description: exp.toString()),
        ),
      );
    }
  }

  late final BookmarkedQuestionsSourceDataImpl
      _bookmarkedQuestionsSourceDataImpl;
  late final BookmarkedBooksSourceDataImpl _bookmarkedBooksSourceDataImpl;
}
