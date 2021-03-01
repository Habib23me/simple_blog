part of 'comment_bloc.dart';

mixin _ReadStateMixin on Bloc<CommentEvent, CommentState> {
  Stream<CommentState> _showLoadingState() async* {
    yield state.copyWith(CommentStatus.loading);
  }

  Stream<CommentState> _showLoadingErrorState() async* {
    yield state.copyWith(CommentStatus.loadingError);
  }

  @protected
  Stream<CommentState> _showLoadedState(
    List<Comment> comments, {
    bool shouldReload = true,
  }) async* {
    if (shouldReload) {
      yield state.copyWith(
        CommentStatus.loaded,
        comments: comments,
      );
    } else {
      yield state.copyWith(
        CommentStatus.loaded,
        comments: List.from(state.comments)..addAll(comments),
      );
    }
  }
}

mixin _CreateStateMixin on Bloc<CommentEvent, CommentState> {
  Stream<CommentState> _showCreatingState() async* {
    yield state.copyWith(CommentStatus.creating);
  }

  Stream<CommentState> _showCreatingErrorState() async* {
    yield state.copyWith(CommentStatus.creatingError);
  }

  @protected
  Stream<CommentState> _showCreatedState(Comment comment) async* {
    yield state.copyWith(
      CommentStatus.created,
      comments: List.from(state.comments)..insert(0,comment),
    );
  }
}

mixin _EditStateMixin on Bloc<CommentEvent, CommentState> {
  Stream<CommentState> _showEditingState() async* {
    yield state.copyWith(CommentStatus.editing);
  }

  Stream<CommentState> _showEditingErrorState() async* {
    yield state.copyWith(CommentStatus.editingError);
  }

  @protected
  Stream<CommentState> _showEditedState(Comment comment) async* {
    yield state.copyWith(
      CommentStatus.edited,
      comments: state.comments.findAndReplaceById(comment.id, comment),
    );
  }
}

mixin _DeleteStateMixin on Bloc<CommentEvent, CommentState> {
  Stream<CommentState> _showDeletingState() async* {
    yield state.copyWith(CommentStatus.deleting);
  }

  Stream<CommentState> _showDeletingErrorState() async* {
    yield state.copyWith(CommentStatus.deletingError);
  }

  @protected
  Stream<CommentState> _showDeletedState(String id) async* {
    yield state.copyWith(
      CommentStatus.deleted,
      comments: state.comments.findAndRemoveById(id),
    );
  }
}
