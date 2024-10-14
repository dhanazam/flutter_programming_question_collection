import 'package:flutter/material.dart';
import 'package:google_books_api/googl_books_api.dart';

class BookListItem extends StatelessWidget {
  const BookListItem({required this.book, super.key});

  final Book book;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Material(
      child: ListTile(
        leading: Text(book.id, style: textTheme.bodySmall),
        title: Text(book.volumeInfo.title),
        isThreeLine: true,
        subtitle: Text(book.volumeInfo.subtitle),
        dense: true,
      ),
    );
  }
}
