part of 'signin_bloc.dart';

@immutable
abstract class SigninEvent extends Equatable {
  const SigninEvent();
}

class SignInEmailChange extends SigninEvent {
  final String email;

  SignInEmailChange({required this.email});
  @override
  List<Object?> get props => [email];
  @override
  String toString() => 'Email change: $email';
}

class SignInPasswordChange extends SigninEvent {
  final String password;

  const SignInPasswordChange({required this.password});
  @override
  List<Object?> get props => [password];
  String toString() => 'Email change: $password';
}

class SignInButtonPressed extends SigninEvent {
  final String email;
  final String password;

  SignInButtonPressed({required this.email, required this.password});
  @override
  List<Object?> get props => [email, password];
  @override
  String toString() => 'Email and password change: $email and $password';
}
