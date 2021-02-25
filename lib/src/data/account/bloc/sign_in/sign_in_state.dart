part of 'sign_in_bloc.dart';

abstract class SignInState extends Equatable {
  const SignInState();

  @override
  List<Object> get props => [];
}

class InitialSignInState extends SignInState {}

class SigningInState extends SignInState {}

class SignedInState extends SignInState {}

class ErrorSignInState extends SignInState {
  final String message;

  ErrorSignInState(this.message);
}
