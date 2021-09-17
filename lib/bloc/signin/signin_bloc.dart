import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:test_register/repository/user_repository.dart';
import 'package:test_register/setup/validation.dart';

part 'signin_event.dart';
part 'signin_state.dart';

class SigninBloc extends Bloc<SigninEvent, SignInState> {
  final UserRepository _userRepository;
  SigninBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(SignInState.initital());

  @override
  Stream<SignInState> mapEventToState(
    SigninEvent signinEvent,
  ) async* {
    if (signinEvent is SignInEmailChange) {
      yield state.updatewith(
          isValidEmail: Validators.isValidEmail(signinEvent.email));
    } else if (signinEvent is SignInPasswordChange) {
      yield state.updatewith(
          isValidPassword: Validators.isValidPassword(signinEvent.password));
    } else if (signinEvent is SignInButtonPressed) {
      yield SignInState.loading();
      try {
        await _userRepository.signIn(
            email: signinEvent.email, password: signinEvent.password);
        yield SignInState.success();
      } catch (exception) {
        print(exception.toString());
        yield SignInState.failure();
      }
    }
  }
}
