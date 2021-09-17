// ignore_for_file: prefer_const_constructors
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:test_register/data/models/book.dart';

part 'bookmark_event.dart';
part 'bookmark_state.dart';

class BookmarkBloc extends Bloc<BookmarkEvent, BookmarkState> {
  BookmarkBloc() : super(BookmarkLoading());

  @override
  Stream<BookmarkState> mapEventToState(
    BookmarkEvent event,
  ) async* {
    if (event is BookmarkStart) {
      yield* _mapBookmarkStartToState();
    } else if (event is BookmarkPressed) {
      yield* _mapBookmarkPressedToState(event, state);
    } else if (event is RemoveBookmark) {
      yield* _mapRemoveBookmarkToState(event, state);
    }
  }

  Stream<BookmarkState> _mapBookmarkStartToState() async* {
    yield BookmarkLoading();
    try {
      await Future.delayed(Duration(seconds: 1));
      yield BookmarkListLoaded(const []);
    } catch (_) {}
  }

  Stream<BookmarkState> _mapBookmarkPressedToState(
      BookmarkPressed event, BookmarkState state) async* {
    if (state is BookmarkListLoaded) {
      try {
        yield BookmarkListLoaded(
            List.from(state.listbookmark)..add(event.bookmark));
      } catch (error) {
        print(error.toString());
      }
    }
  }

  Stream<BookmarkState> _mapRemoveBookmarkToState(
      RemoveBookmark event, BookmarkState state) async* {
    if (state is BookmarkListLoaded) {
      try {
        yield BookmarkListLoaded(
            List.from(state.listbookmark)..remove(event.bookmark));
      } catch (error) {
        print(error.toString());
      }
    }
  }
}
