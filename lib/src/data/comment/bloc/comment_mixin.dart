part of 'comment_bloc.dart';

mixin _ReadCommentsMixin on Bloc<CommentEvent, CommentState> {
  Stream<CommentState> _showLoadingState() async* {
    yield state.copyWith(
      getStatus: GetCommentStatus.loading,
      createStatus: CreateCommentStatus.initial,
    );
  }

  Stream<CommentState> _showLoadingError() async* {
    yield state.copyWith(
      getStatus: GetCommentStatus.loadingError,
      createStatus: CreateCommentStatus.initial,
    );
  }

  @protected
  Stream<CommentState> _showLoadedState( {
    List<Comment> comments,
    bool shouldReload = true,
  }) async* {
    if (shouldReload) {
      yield state.copyWith(
        getStatus: GetCommentStatus.loaded,
        createStatus: CreateCommentStatus.initial,
        comments: comments,
      );
    } else {
      yield state.copyWith(
        getStatus: GetCommentStatus.loaded,
        createStatus: CreateCommentStatus.initial,
        comments: [...state.comments, ...comments],
      );
    }
  }
}

mixin _EditCommentMixin on Bloc<CommentEvent, CommentState> {
  Stream<CommentState> _showEditingState() async* {
    yield state.copyWith(
      getStatus: GetCommentStatus.editing,
      createStatus: CreateCommentStatus.initial,
    );
  }

  Stream<CommentState> _showEditingError() async* {
    yield state.copyWith(
      getStatus: GetCommentStatus.editingError,
      createStatus: CreateCommentStatus.initial,
    );
  }

  @protected
  Stream<CommentState> _showEditedState(
    Comment comment,
  ) async* {
    yield state.copyWith(
      getStatus: GetCommentStatus.edited,
      createStatus: CreateCommentStatus.initial,
      comments: state.comments.findAndReplaceById(comment.id, comment),
    );
  }
}
mixin _DeleteCommentMixin on Bloc<CommentEvent, CommentState> {
  Stream<CommentState> _showDeletingState() async* {
    yield state.copyWith(
      getStatus: GetCommentStatus.deleting,
      createStatus: CreateCommentStatus.initial,
    );
  }

  Stream<CommentState> _showDeletingError() async* {
    yield state.copyWith(
      getStatus: GetCommentStatus.deletingError,
      createStatus: CreateCommentStatus.initial,
    );
  }

  @protected
  Stream<CommentState> _showDeletedState(String commentId) async* {
    yield state.copyWith(
      getStatus: GetCommentStatus.deleted,
      createStatus: CreateCommentStatus.initial,
      comments: state.comments.findAndRemoveById(commentId),
    );
  }
}
mixin _CreateCommentMixin on Bloc<CommentEvent, CommentState> {
  Stream<CommentState> _showCreatingState() async* {
    yield state.copyWith(
      createStatus: CreateCommentStatus.creating,
      getStatus: GetCommentStatus.initial,
    );
  }

  Stream<CommentState> _showCreatingErrorState() async* {
    yield state.copyWith(
      createStatus: CreateCommentStatus.creatingError,
      getStatus: GetCommentStatus.initial,
    );
  }

  @protected
  Stream<CommentState> _showCreatedState(Comment comment) async* {
    yield state.copyWith(
      createStatus: CreateCommentStatus.created,
      getStatus: GetCommentStatus.initial,
      comments: [comment, ...state.comments],
    );
  }
}
