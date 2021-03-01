part of 'user_posts_bloc.dart';

@immutable
abstract class UserPostsEvent {}

class ReadUserPosts extends UserPostsEvent {}

class ReloadUserPosts extends UserPostsEvent {}

class ReadNextUserPosts extends UserPostsEvent {}

class EditUserPost extends UserPostsEvent {
  final String postId;
  final String caption;

  EditUserPost({this.caption, this.postId});
}

class DeleteUserPost extends UserPostsEvent {
  final String postId;

  DeleteUserPost(this.postId);
}
