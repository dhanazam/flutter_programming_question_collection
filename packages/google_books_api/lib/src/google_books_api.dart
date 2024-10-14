import 'dart:convert';

import 'package:google_books_api/src/models/index.dart';
import 'package:http/http.dart' as http;

class GoogkeBooksApi {
  Future<List<Book>> searchBooks() async {
    var queryUrl = "https://www.googleapis.com/books/v1/volumes?q="
        "subject"
        "&maxResults=10"
        "&startIndex=0"
        "'&langRestrict=en"
        "&orderBy=relevance"
        "'&printType=book'";

    final List<Book> books = [];

    await http.get(Uri.parse(queryUrl)).then((result) {
      if (result.statusCode == 200) {
        jsonDecode(result.body)['items'].forEach((item) {
          books.add(Book.fromJson(item));
        });
      } else {
        throw SearchFailedException();
      }
    });
    return books;
  }
}

class SearchFailedException implements Exception {}
