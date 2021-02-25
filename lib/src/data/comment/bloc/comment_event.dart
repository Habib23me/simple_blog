part of 'comment_bloc.dart';

abstract class CommentEvent extends Equatable {
  const CommentEvent();

  @override
  List<Object> get props => [];
}

class ReadComments extends CommentEvent {}

class ReloadComments extends CommentEvent {}

class ReadNextComments extends CommentEvent {}

class CreateCommet extends CommentEvent {
  final String comment;
  @override
  List<Object> get props => [comment];
  CreateCommet(this.comment);
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
