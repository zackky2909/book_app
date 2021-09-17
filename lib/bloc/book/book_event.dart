part of 'book_bloc.dart';

@immutable
abstract class BookEvent extends Equatable {
  const BookEvent();

  @override
  List<Object> get props => [];
}

@immutable
class LoadBook extends BookEvent {}

@immutable
class UpdateBook extends BookEvent {
  final List<Book> book;

  const UpdateBook(this.book);

  @override
  List<Object> get props => [book];
}
