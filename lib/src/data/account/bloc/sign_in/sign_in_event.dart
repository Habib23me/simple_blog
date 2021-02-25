part of 'sign_in_bloc.dart';

class SignInEvent extends Equatable {
  final String email;
  final String password;

  SignInEvent({
    @required this.email,
    @required this.password,
  });

  @override
  List<Object> get props => [
        email,
        password,
      ];
}
