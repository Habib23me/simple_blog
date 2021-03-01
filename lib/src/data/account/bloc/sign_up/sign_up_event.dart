part of 'sign_up_bloc.dart';

class SignUpEvent extends Equatable {
  final SignUpPayload signUpPayload;

  SignUpEvent(this.signUpPayload);

  @override
  List<Object> get props => [
        signUpPayload,
      ];
}
