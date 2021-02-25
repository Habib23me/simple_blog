part of 'comment_bloc.dart';

enum CommentStatus {
  intial,
  loading,
  loaded,
  loadingError,
  creating,
  created,
  creatingError,
  editing,
  edited,
  editingError,
  deleting,
  deleted,
  deletingError
}

class CommentState extends Equatable {
  final List<Comment> comments;
  final CommentStatus status;

  CommentState(this.status, {this.comments = const []});

  @override
  List<Object> get props => [comments, status];

  CommentState copyWith(
    CommentStatus status, {
    List<Comment> comments,
  }) {
    return CommentState(
      status ?? this.status,
      comments: comments ?? this.comments,
    );
  }
}
