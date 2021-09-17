import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:test_register/repository/user_repository.dart';
import 'package:test_register/setup/validation.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignUpEvent, SignUpState> {
  UserRepository _userRepository;
  SignupBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(SignUpState.initital());

  @override
  Stream<SignUpState> mapEventToState(
    SignUpEvent signupevent,
  ) async* {
    if (signupevent is SignupEmailChange) {
      yield state.updatewith(
          isValidEmail: Validators.isValidEmail(signupevent.email));
    } else if (signupevent is SignupPasswordChange) {
      yield state.updatewith(
          isValidPassword: Validators.isValidPassword(signupevent.password));
    } else if (signupevent is SignupButtonPressed) {
      yield SignUpState.loading();
      try {
        await _userRepository.signUp(
            email: signupevent.email, password: signupevent.password);
        yield SignUpState.success();
      } catch (exception) {
        yield SignUpState.failure();
      }
    }
  }
}
