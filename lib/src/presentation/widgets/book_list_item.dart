import 'package:flutter/material.dart';
import 'package:google_books_api/googl_books_api.dart';

class BookListItem extends StatelessWidget {
  const BookListItem({required this.book, super.key});

  final Book book;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListTile(
        leading: book.volumeInfo.imageLinks.smallThumbnail != null
            ? Image.network(book.volumeInfo.imageLinks.smallThumbnail!,
                width: 50, height: 200, fit: BoxFit.cover)
            : const Icon(Icons.book), // or a default image
        title: Text(book.volumeInfo.title),
        isThreeLine: true,
        subtitle: Text(book.volumeInfo.subtitle),
        dense: true,
      ),
    );
  }
}
