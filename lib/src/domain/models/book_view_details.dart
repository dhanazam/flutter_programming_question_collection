import 'package:flutter_programming_question_collection/src/domain/models/index.dart';

class BookViewDetails {
  final Book book;
  final String? category;
  final List<Book> otherBooks;

  BookViewDetails({
    this.category,
    required this.book,
    required this.otherBooks,
  });

  Map<String, dynamic> toJson() {
    return {
      'book': book,
      'category': category,
      'otherBooks': otherBooks,
    };
  }
}
