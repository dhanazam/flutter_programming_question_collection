import 'dart:convert';

import 'package:google_books_api/src/models/index.dart';
import 'package:http/http.dart' as http;

class GoogleBooksApi {
  const GoogleBooksApi({required this.apiKey});

  final String apiKey;
  Future<List<Book>> searchBooks({int startIndex = 0}) async {
    var queryUrl =
        "https://www.googleapis.com/books/v1/volumes?q=programming&maxResults=10&startIndex=$startIndex&langRestrict=en&orderBy=relevance&printType=books&subject=Computers&key=$apiKey";

    final List<Book> books = [];

    await http.get(Uri.parse(queryUrl)).then((result) {
      if (result.statusCode == 200) {
        ((jsonDecode(result.body))['items'] as List<dynamic>?)?.forEach((item) {
          try {
            books.add(Book.fromJson(item));
          } catch (e) {
            throw InvalidFormatException();
          }
        });
      } else {
        throw SearchFailedException();
      }
    });
    return books;
  }
}

class SearchFailedException implements Exception {}

class InvalidFormatException implements Exception {}
