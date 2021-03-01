import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:simple_blog/simple_blog.dart';

part 'user_event.dart';
part 'user_state.dart';
part 'user_mixin.dart';

class UserBloc extends Bloc<UserEvent, UserState> with UserStateMixin {
  UserRepository userRepository;
  UserBloc({@required this.userRepository})
      : assert(userRepository != null),
        super(UserState(UserStatus.intial));

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is GetUserEvent) {
      yield* _showLoadingState();
      yield* _getUser();
    }
  }

  Stream<UserState> _getUser() async* {
    try {
      final user = await userRepository.getUser();
      yield* _showLoadedState(user);
    } catch (e) {
      yield* _showErrorState();
    }
  }
}
