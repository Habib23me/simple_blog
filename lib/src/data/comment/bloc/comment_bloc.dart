import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:simple_blog/simple_blog.dart';
import 'package:equatable/equatable.dart';
import 'package:simple_blog/src/data/comment/comment.dart';

part 'comment_event.dart';
part 'comment_mixin.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState>
    with
        _ReadCommentsMixin,
        _CreateCommentMixin,
        _EditCommentMixin,
        _DeleteCommentMixin {
  PageMetaData metaData;
  final CommentRepository commentRepository;
  CommentBloc({@required this.commentRepository})
      : assert(commentRepository != null),
        super(CommentState(
            getStatus: GetCommentStatus.initial,
            createStatus: CreateCommentStatus.initial));

  @override
  Stream<CommentState> mapEventToState(
    CommentEvent event,
  ) async* {
    if (event is ReadComments) {
      yield* _showLoadingState();
      yield* _read(postId: event.postId, page: 1, shouldReload: true);
    } else if (event is ReloadComments) {
      yield* _read(postId: event.postId, page: 1, shouldReload: true);
    } else if (event is ReadNextComments) {
      if (metaData?.hasNextPage ?? false) {
        yield* _read(
          postId: event.postId,
          page: metaData.nextPage,
          shouldReload: false,
        );
      }
    } else if (event is EditComments) {
      yield* _editComment(
        event.commentId,
        event.comment,
      );
    } else if (event is DeleteComments) {
      yield* _deleteComment(event.commentId);
    } else if (event is CommenToPost) {
      yield* _commentToPost(event.commentPayload);
    }
  }

  Stream<CommentState> _read({
    String postId,
    int page = 1,
    bool shouldReload = true,
  }) async* {
    try {
      var comments = await commentRepository.readComments(postId, page);

      metaData = comments.metaData;
      yield* _showLoadedState(
          shouldReload: shouldReload, comments: comments.docs);
    } catch (e) {
      yield* _showLoadingError();
    }
  }

  Stream<CommentState> _commentToPost(CommentPayload commentPayload) async* {
    try {
      yield* _showCreatingState();
      var post = await commentRepository.create(commentPayload);
      yield* _showCreatedState(post);
    } catch (e) {
      yield* _showCreatingErrorState();
    }
  }

  Stream<CommentState> _editComment(
      String commentId, String newComment) async* {
    try {
      yield* _showEditingState();
      var comment = await commentRepository.edit(commentId, newComment);
      yield* _showEditedState(comment);
    } catch (e) {
      yield* _showEditingError();
    }
  }

  Stream<CommentState> _deleteComment(String commentId) async* {
    try {
      yield* _showDeletingState();
      await commentRepository.delete(commentId);
      yield* _showDeletedState(commentId);
    } catch (e) {
      yield* _showDeletingError();
    }
  }
}
