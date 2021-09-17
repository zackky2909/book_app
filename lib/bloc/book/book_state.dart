part of 'book_bloc.dart';

abstract class BookState extends Equatable {
  const BookState();

  @override
  List<Object> get props => [];
}

class BookLoading extends BookState {}

class BookLoaded extends BookState {
  final List<Book> listbook;

  BookLoaded({this.listbook = const <Book>[]});

  @override
  List<Object> get props => [listbook];
}
