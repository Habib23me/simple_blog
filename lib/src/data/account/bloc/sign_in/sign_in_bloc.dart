import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:simple_blog/simple_blog.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';
part 'sign_in_mixin.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> with _StateMixin {
  final AccountRepository accountRepository;

  SignInBloc({@required this.accountRepository})
      : assert(accountRepository != null),
        super(InitialSignInState());

  @override
  Stream<SignInState> mapEventToState(
    SignInEvent event,
  ) async* {
    try {
      _showSignInState();
      await accountRepository.signIn(
        email: event.email,
        password: event.password,
      );
      _showSignedInState();
    } on NetworkException catch (e) {
      _showSigningInErrorState(e.message);
    }
  }
}
