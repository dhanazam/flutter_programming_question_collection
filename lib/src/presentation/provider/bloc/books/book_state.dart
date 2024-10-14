part of 'book_bloc.dart';

enum BookStatus { initial, success, failure }

final class BookState extends Equatable {
  const BookState({
    this.status = BookStatus.initial,
    this.books = const [],
    this.hasReachedMax = false,
  });

  final BookStatus status;
  final List<Book> books;
  final bool hasReachedMax;

  BookState copyWith({
    BookStatus? status,
    List<Book>? books,
    bool? hasReachedMax,
  }) {
    return BookState(
      status: status ?? this.status,
      books: books ?? this.books,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''BookState { status: $status, hasReachedMax: $hasReachedMax, books: ${books.length} }''';
  }

  @override
  List<Object> get props => [status, books, hasReachedMax];
}
