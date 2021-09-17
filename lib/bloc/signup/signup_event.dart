part of 'signup_bloc.dart';

@immutable
abstract class SignUpEvent extends Equatable {
  const SignUpEvent();
}

class SignupEmailChange extends SignUpEvent {
  final String email;

  SignupEmailChange({required this.email});
  @override
  List<Object?> get props => [email];
  @override
  String toString() => 'Email change: $email';
}

class SignupPasswordChange extends SignUpEvent {
  final String password;

  const SignupPasswordChange({required this.password});
  @override
  List<Object?> get props => [password];
  @override
  String toString() => 'Email change: $password';
}

class SignupButtonPressed extends SignUpEvent {
  final String email;
  final String password;

  const SignupButtonPressed({required this.email, required this.password});
  @override
  List<Object?> get props => [email, password];
  String toString() => 'Email and password change: $email and $password';
}
