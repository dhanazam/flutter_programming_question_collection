import 'package:flutter_programming_question_collection/src/data/datasources/local/base/base_cache_service.dart';
import 'package:flutter_programming_question_collection/src/domain/models/book/book.dart';
import 'package:flutter_programming_question_collection/src/domain/models/book/book_category.dart';

abstract class BookmarkedBooksSourceData {
  Future<List<BookCategory>> getBookCategoriesFromSource();
  Future<List<Book>> getBookMarkedBooksByCategory(String categoryName);
}

class BookmarkedBooksSourceDataImpl implements BookmarkedBooksSourceData {
  BookmarkedBooksSourceDataImpl() : _cacheService = CacheService();
  late final CacheService _cacheService;

  @override
  Future<List<BookCategory>> getBookCategoriesFromSource() async {
    final datas =
        _cacheService.bookmarkedBooksCategories.values.where((category) {
      return category.books!.isNotEmpty;
    });
    return datas.toList().cast();
  }

  @override
  Future<List<Book>> getBookMarkedBooksByCategory(String categoryName) async {
    final category = _cacheService.bookmarkedBooksCategories.get(categoryName);
    if (category != null && category.books!.isNotEmpty) {
      return category.books!;
    }
    return [];
  }
}
