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
      yield* _showSigningUpState();
      await accountRepository.signUp(event.signUpPayload);
      yield* _showSignedUpState();
    } on NetworkException catch (e) {
      yield* _showSigningUpErrorState(e.message);
    }
  }
}
