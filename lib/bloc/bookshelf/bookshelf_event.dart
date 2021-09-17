part of 'bookshelf_bloc.dart';

abstract class BookshelfEvent extends Equatable {
  const BookshelfEvent();

  @override
  List<Object> get props => [];
}

class BookshelfStart extends BookshelfEvent {}

class AddBookshelf extends BookshelfEvent {
  final Book bookshelf;

  const AddBookshelf({required this.bookshelf});

  @override
  List<Object> get props => [bookshelf];
}

class RemoveBookshelf extends BookshelfEvent {
  final Book bookshelf;

  const RemoveBookshelf({required this.bookshelf});

  @override
  List<Object> get props => [bookshelf];
}
