part of 'category_bloc.dart';

enum CategoryEvents {
  bookmarkQuestionInitial,
  fetchBookmarkedQuestionsStart,
  fetchBookmarkedQuestionsSuccess,
  fetchBookmarkedQuestionsError,

  fetchBookmarkedQuestionsForCategory,
  fetchBookmarkedQuestionsForCategoryError,
  removeBookmarkedQuestion,

  bookmarkBookInitial,
  fetchBookmarkedBooksStart,
  fetchBookmarkedBooksSuccess,
  fetchBookmarkedBooksError,

  fetchBookmarkedBooksForCategory,
  fetchBookmarkedBooksForCategoryError,
  removeBookmarkedBook,
}

class CategoryEvent {
  CategoryEvents? type;
  dynamic payload;
  Question? question;
  Book? book;

  CategoryEvent.bookmarkQuestionInitial(String category, this.question) {
    type = CategoryEvents.bookmarkQuestionInitial;
    payload = category;
  }

  CategoryEvent.fetchBookmarkedQuestionsForCategory(String categoryName) {
    type = CategoryEvents.fetchBookmarkedQuestionsForCategory;
    payload = categoryName;
  }

  CategoryEvent.removeBookmarkedQuestion(String categoryName, this.question) {
    type = CategoryEvents.removeBookmarkedQuestion;
    payload = categoryName;
  }
}
