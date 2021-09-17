part of 'bookshelf_bloc.dart';

@immutable
abstract class BookshelfState extends Equatable {
  const BookshelfState();

  @override
  List<Object> get props => [];
}

class BookshelfLoading extends BookshelfState {}

@immutable
class BookshelfLoaded extends BookshelfState {
  List<Book> listbookshelf = const [];

  BookshelfLoaded(this.listbookshelf);

  @override
  List<Object> get props => [listbookshelf];
}
