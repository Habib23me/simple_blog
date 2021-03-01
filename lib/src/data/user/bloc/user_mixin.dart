part of 'user_bloc.dart';

mixin UserStateMixin on Bloc<UserEvent, UserState> {
  Stream<UserState> _showLoadingState() async* {
    yield state.copyWith(UserStatus.loading);
  }

  Stream<UserState> _showErrorState() async* {
    yield state.copyWith(UserStatus.error);
  }

  @protected
  Stream<UserState> _showLoadedState(User user) async* {
    yield state.copyWith(
      UserStatus.loaded,
      user: user,
    );
  }
}
