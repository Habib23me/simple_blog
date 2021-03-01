part of 'comment_bloc.dart';

abstract class CommentEvent extends Equatable {
  const CommentEvent();

  @override
  List<Object> get props => [];
}

class ReadComments extends CommentEvent {
  final String postId;
  @override
  List<Object> get props => [postId];

  ReadComments(this.postId);
}

class ReloadComments extends CommentEvent {
  final String postId;
  @override
  List<Object> get props => [postId];

  ReloadComments(this.postId);
}

class ReadNextComments extends CommentEvent {
  final String postId;
  @override
  List<Object> get props => [postId];

  ReadNextComments(this.postId);
}

class CreateComment extends CommentEvent {
  final String comment;
  final String postId;
  @override
  List<Object> get props => [comment];
  CreateComment({this.comment, this.postId});
}

class DeleteComment extends CommentEvent {
  final String id;
  @override
  List<Object> get props => [id];

  DeleteComment(this.id);
}

class EditComment extends CommentEvent {
  final String id;
  final String comment;
  @override
  List<Object> get props => [id, comment];
  EditComment({@required this.id, @required this.comment});
}
