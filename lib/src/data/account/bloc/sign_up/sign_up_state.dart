part of 'sign_up_bloc.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}

class InitialSignUpState extends SignUpState {}

class SigningUpState extends SignUpState {}

class SignedUpState extends SignUpState {}

class ErrorSignUpState extends SignUpState {
  final String message;

  ErrorSignUpState(this.message);
}
