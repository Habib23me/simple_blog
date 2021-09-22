part of 'comment_bloc.dart';

@immutable
abstract class CommentEvent {}

class ReadComments extends CommentEvent {
  final String postId;
  ReadComments(this.postId);
}

class ReloadComments extends CommentEvent {
  final String postId;

  ReloadComments(this.postId);
}

class ReadNextComments extends CommentEvent {
  final String postId;

  ReadNextComments(this.postId);
}

class CommenToPost extends CommentEvent {
  final CommentPayload commentPayload;

  CommenToPost(this.commentPayload);
}

class EditComments extends CommentEvent {
  final String commentId;
  final String comment;

  EditComments({this.comment, this.commentId});
}

class DeleteComments extends CommentEvent {
  final String commentId;

  DeleteComments(this.commentId);
}
