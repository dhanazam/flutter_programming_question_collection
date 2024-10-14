import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_books_api/googl_books_api.dart';
import 'package:http/http.dart' as http;

part 'book_event.dart';
part 'book_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  BookBloc({required this.httpClient}) : super(const BookState()) {
    on<BookFetched>(_onBookFetched);
  }

  final http.Client httpClient;

  FutureOr<void> _onBookFetched(
      BookFetched event, Emitter<BookState> emit) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == BookStatus.initial) {
        final books = await _fetchBooks();
        return emit(
          state.copyWith(
            status: BookStatus.success,
            books: books,
            hasReachedMax: false,
          ),
        );
      }
      final books = await _fetchBooks(state.books.length);
      books.isEmpty
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(
              state.copyWith(
                status: BookStatus.success,
                books: List.of(state.books)..addAll(books),
                hasReachedMax: false,
              ),
            );
    } catch (_) {
      emit(state.copyWith(status: BookStatus.failure));
    }
  }

  Future<List<Book>> _fetchBooks([int startIndex = 0]) async {
    final List<Book> response = await GoogkeBooksApi().searchBooks();
    return response;
  }
}
