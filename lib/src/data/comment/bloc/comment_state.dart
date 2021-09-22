part of 'comment_bloc.dart';

enum GetCommentStatus {
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

enum CreateCommentStatus {
  initial,
  loading,
  loaded,
  loadingError,
  creating,
  created,
  creatingError,
}

@immutable
class CommentState extends Equatable {
  final CreateCommentStatus createStatus;
  final GetCommentStatus getStatus;
  final List<Comment> comments;

  CommentState({this.createStatus, this.getStatus, this.comments = const []});

  @override
  List<Object> get props => [getStatus, createStatus, comments];

  CommentState copyWith({
    GetCommentStatus getStatus,
    CreateCommentStatus createStatus,
    List<Comment> comments,
  }) {
    return CommentState(
      getStatus: getStatus ?? this.getStatus,
      createStatus: createStatus ?? this.createStatus,
      comments: comments ?? this.comments,
    );
  }
}
