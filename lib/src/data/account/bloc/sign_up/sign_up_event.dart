part of 'sign_up_bloc.dart';

class SignUpEvent extends Equatable {
  final String email;
  final String password;
  final String fullName;

  SignUpEvent({
    @required this.email,
    @required this.password,
    @required this.fullName,
  });

  @override
  List<Object> get props => [
        email,
        password,
        fullName,
      ];
}
