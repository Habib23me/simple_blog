part of 'user_posts_bloc.dart';

enum UserPostsStatus {
  initial,
  loading,
  loaded,
  loadingError,
  editing,
  edited,
  editingError,
  deleting,
  deleted,
  deletingError,
}

@immutable
class UserPostsState extends Equatable {
  final UserPostsStatus status;
  final List<Post> posts;

  UserPostsState(this.status, {this.posts = const []});

  @override
  List<Object> get props => [status];

  UserPostsState copyWith(
    UserPostsStatus feedStatus, {
    List<Post> posts,
  }) {
    return UserPostsState(
      feedStatus ?? this.status,
      posts: posts ?? this.posts,
    );
  }
}
