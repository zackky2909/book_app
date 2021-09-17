part of 'bookmark_bloc.dart';

@immutable
abstract class BookmarkState extends Equatable {
  const BookmarkState();

  @override
  List<Object> get props => [];
}

class BookmarkLoading extends BookmarkState {}

@immutable
class BookmarkListLoaded extends BookmarkState {
  List<Book> listbookmark = const [];

  BookmarkListLoaded(this.listbookmark);

  @override
  List<Object> get props => [listbookmark];
}
