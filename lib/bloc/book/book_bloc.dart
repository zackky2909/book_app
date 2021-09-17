// ignore_for_file: avoid_renaming_method_parameters

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:test_register/data/models/book.dart';
import 'package:test_register/repository/book_repo.dart';

part 'book_event.dart';
part 'book_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  final BookRepo _bookRepo;
  StreamSubscription? _streamSubscription;
  BookBloc({required BookRepo bookRepo})
      : _bookRepo = bookRepo,
        super(BookLoading());

  @override
  Stream<BookState> mapEventToState(
    BookEvent bookevent,
  ) async* {
    if (bookevent is LoadBook) {
      yield* _mapLoadBookToState();
    }
    if (bookevent is UpdateBook) {
      yield* _mapUpdateBookToState(bookevent);
    }
  }

  Stream<BookState> _mapLoadBookToState() async* {
    _streamSubscription?.cancel();
    _streamSubscription =
        _bookRepo.bookStream().listen((book) => add(UpdateBook(book)));
  }

  Stream<BookState> _mapUpdateBookToState(UpdateBook bookevent) async* {
    yield BookLoaded(listbook: bookevent.book);
  }
}
