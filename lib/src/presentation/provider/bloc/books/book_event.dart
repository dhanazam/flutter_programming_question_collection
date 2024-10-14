part of 'book_bloc.dart';

sealed class BookEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class BookFetched extends BookEvent {}
