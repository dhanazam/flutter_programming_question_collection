import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_programming_question_collection/src/presentation/provider/bloc/books/book_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_programming_question_collection/src/presentation/widgets/index.dart';

class BookScreen extends StatelessWidget {
  const BookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) =>
            BookBloc(httpClient: http.Client())..add(BookFetched()),
        child: const BookList(),
      ),
    );
  }
}

class BookList extends StatefulWidget {
  const BookList({super.key});

  @override
  State<BookList> createState() => _BookListState();
}

class _BookListState extends State<BookList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookBloc, BookState>(
      builder: (context, state) {
        switch (state.status) {
          case BookStatus.failure:
            return const Center(child: Text('failed to fetch books'));
          case BookStatus.success:
            if (state.books.isEmpty) {
              return const Center(child: Text('no books'));
            }
            return ListView.builder(
              itemBuilder: (BuildContext contex, int index) {
                return index >= state.books.length
                    ? const BottomLoader()
                    : BookListItem(book: state.books[index]);
              },
              itemCount: state.hasReachedMax
                  ? state.books.length
                  : state.books.length + 1,
              controller: _scrollController,
            );

          case BookStatus.initial:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<BookBloc>().add(BookFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
