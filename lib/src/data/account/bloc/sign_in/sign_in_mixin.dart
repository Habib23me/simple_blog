part of 'sign_in_bloc.dart';

mixin _StateMixin on Bloc<SignInEvent, SignInState> {
  Stream<SignInState> _showSignInState() async* {
    yield SigningInState();
  }

  Stream<SignInState> _showSignedInState() async* {
    yield SignedInState();
  }

  @protected
  Stream<SignInState> _showSigningInErrorState(String message) async* {
    yield ErrorSignInState(message);
  }
}
