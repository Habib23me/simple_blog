part of 'sign_up_bloc.dart';

mixin _StateMixin on Bloc<SignUpEvent, SignUpState> {
  Stream<SignUpState> _showSigningUpState() async* {
    yield SigningUpState();
  }

  Stream<SignUpState> _showSignedUpState() async* {
    yield SignedUpState();
  }

  @protected
  Stream<SignUpState> _showSigningUpErrorState(String message) async* {
    yield ErrorSignUpState(message);
  }
}
