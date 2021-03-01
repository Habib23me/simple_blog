part of 'user_bloc.dart';

enum UserStatus {
  intial,
  loading,
  loaded,
  error,
}

@immutable
class UserState extends Equatable {
  final UserStatus status;
  final User user;

  UserState(
    this.status, {
    this.user,
  });

  @override
  String toString() => 'UserState(status: $status, user: $user)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is UserState && o.status == status && o.user == user;
  }

  @override
  int get hashCode => status.hashCode ^ user.hashCode;

  @override
  List<Object> get props => [status, user];

  UserState copyWith(
    UserStatus status, {
    User user,
  }) {
    return UserState(
      status ?? this.status,
      user: user ?? this.user,
    );
  }
}
