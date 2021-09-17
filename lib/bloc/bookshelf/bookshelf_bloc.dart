// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:test_register/data/models/book.dart';

part 'bookshelf_event.dart';
part 'bookshelf_state.dart';

class BookshelfBloc extends Bloc<BookshelfEvent, BookshelfState> {
  BookshelfBloc() : super(BookshelfLoading());

  @override
  Stream<BookshelfState> mapEventToState(
    BookshelfEvent event,
  ) async* {
    if (event is BookshelfStart) {
      yield* _mapBookshelfStartToState();
    } else if (event is AddBookshelf) {
      yield* _mapBookshelfPressedToState(event, state);
    } else if (event is RemoveBookshelf) {
      yield* _mapRemoveBookshelfToState(event, state);
    }
  }

  Stream<BookshelfState> _mapBookshelfStartToState() async* {
    yield BookshelfLoading();
    try {
      await Future.delayed(Duration(seconds: 1));
      yield BookshelfLoaded(const []);
    } catch (_) {}
  }

  Stream<BookshelfState> _mapBookshelfPressedToState(
      AddBookshelf event, BookshelfState state) async* {
    if (state is BookshelfLoaded) {
      try {
        yield BookshelfLoaded(
            List.from(state.listbookshelf)..add(event.bookshelf));
      } catch (_) {}
    }
  }

  Stream<BookshelfState> _mapRemoveBookshelfToState(
      RemoveBookshelf event, BookshelfState state) async* {
    if (state is BookshelfLoaded) {
      try {
        yield BookshelfLoaded(
            List.from(state.listbookshelf)..remove(event.bookshelf));
      } catch (_) {}
    }
  }
}
