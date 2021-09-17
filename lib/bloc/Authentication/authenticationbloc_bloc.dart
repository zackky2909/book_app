import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_register/repository/user_repository.dart';

part 'authenticationbloc_event.dart';
part 'authenticationbloc_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository _userRepository;
  AuthenticationBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(AuthenticationInitial());

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AuthenticationStart) {
      final isSignIn = await _userRepository.isSignedIn();
      if (isSignIn) {
        final user = await _userRepository.getUser();
        yield AuthenticationSuccess(user: user);
      } else {
        yield AuthenticationFailure();
      }
    } else if (event is AuthenticationLoggedIn) {
      yield AuthenticationSuccess(user: await _userRepository.getUser());
    } else if (event is AuthenticationLoggedOut) {
      _userRepository.signOut();
      yield AuthenticationFailure();
    }
  }
}
