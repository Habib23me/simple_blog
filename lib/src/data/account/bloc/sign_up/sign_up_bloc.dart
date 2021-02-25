import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:simple_blog/simple_blog.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';
part 'sign_up_mixins.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> with _StateMixin {
  final AccountRepository accountRepository;

  SignUpBloc({@required this.accountRepository})
      : assert(accountRepository != null),
        super(InitialSignUpState());

  @override
  Stream<SignUpState> mapEventToState(
    SignUpEvent event,
  ) async* {
    try {
      _showSigningUpState();
      await accountRepository.signUp(
        email: event.email,
        password: event.password,
        fullName: event.fullName,
      );
      _showSignedUpState();
    } on NetworkException catch (e) {
      _showSigningUpErrorState(e.message);
    }
  }
}
