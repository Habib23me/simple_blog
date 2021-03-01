part of 'sign_in_bloc.dart';

class SignInEvent extends Equatable {
  final SignInPayload signInPayload;
  SignInEvent(this.signInPayload);

  @override
  List<Object> get props => [
        signInPayload,
      ];
}
