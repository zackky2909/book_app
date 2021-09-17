part of 'authenticationbloc_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationSuccess extends AuthenticationState {
  final User? user;

  const AuthenticationSuccess({required this.user});
}

class AuthenticationFailure extends AuthenticationState {}
