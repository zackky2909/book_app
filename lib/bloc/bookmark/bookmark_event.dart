part of 'bookmark_bloc.dart';

abstract class BookmarkEvent extends Equatable {
  const BookmarkEvent();

  @override
  List<Object> get props => [];
}

class BookmarkStart extends BookmarkEvent {}

class BookmarkPressed extends BookmarkEvent {
  final Book bookmark;

  const BookmarkPressed({required this.bookmark});

  @override
  List<Object> get props => [bookmark];
}

class RemoveBookmark extends BookmarkEvent {
  final Book bookmark;

  const RemoveBookmark({required this.bookmark});

  @override
  List<Object> get props => [bookmark];
}
