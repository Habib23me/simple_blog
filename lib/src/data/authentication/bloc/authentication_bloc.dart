import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:simple_blog/simple_blog.dart';
import 'package:meta/meta.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationStatus> {
  final AccountRepository accountRepository;
  AuthenticationBloc({@required this.accountRepository})
      : assert(accountRepository != null),
        super(AuthenticationStatus.unknown);
  @override
  Stream<AuthenticationStatus> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    switch (event) {
      case AuthenticationEvent.getAuthState:
        {
          if (await isSignedIn) {
            yield AuthenticationStatus.authenticated;
          } else {
            yield AuthenticationStatus.unauthenticated;
          }
          break;
        }
      case AuthenticationEvent.authenticate:
        yield AuthenticationStatus.authenticated;
        break;
      case AuthenticationEvent.unAuthenticate:
        await accountRepository.signOut();
        yield AuthenticationStatus.unauthenticated;
        break;
    }
  }

  Future<bool> get isSignedIn => accountRepository.isSignedIn();
}
