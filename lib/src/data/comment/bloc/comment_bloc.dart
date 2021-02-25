import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simple_blog/simple_blog.dart';
import 'package:meta/meta.dart';
         
part 'comment_event.dart';
part 'comment_state.dart';
part 'comment_mixin.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState>
    with
        _ReadStateMixin,
        _CreateStateMixin,
        _EditStateMixin,
        _DeleteStateMixin {
  PageMetaData metaData;
  final CommentRepository commentRepository;
  CommentBloc({@required this.commentRepository})
      : assert(commentRepository != null),
        super(CommentState(CommentStatus.intial));

  @override
  Stream<CommentState> mapEventToState(
    CommentEvent event,
  ) async* {
    if (event is ReadComments) {
      yield* _showLoadingState();
      yield* _read();
    } else if (event is ReloadComments) {
      yield* _read();
    } else if (event is ReadNextComments) {
      if (metaData?.hasNextPage ?? false) {
        yield* _read(
          page: metaData.nextPage,
          shouldReload: false,
        );
      }
    } else if (event is CreateCommet) {
      yield* _create(event.comment);
    } else if (event is EditComment) {
      yield* _edit(event.id, event.comment);
    } else if (event is DeleteComment) {
      yield* _delete(event.id);
    }
  }

  Stream<CommentState> _read({int page, bool shouldReload = true}) async* {
    try {
      var comments = await commentRepository.read(page);
      metaData = comments.metaData;
      yield* _showLoadedState(comments.docs, shouldReload: shouldReload);
    } catch (e) {
      yield* _showLoadingErrorState();
    }
  }

  Stream<CommentState> _create(String comment) async* {
    try {
      _showCreatingState();
      var post = await commentRepository.create(comment);
      _showCreatedState(post);
    } catch (e) {
      _showCreatingErrorState();
    }
  }

  Stream<CommentState> _edit(String id, String comment) async* {
    try {
      _showEditingState();
      var post = await commentRepository.edit(id, comment);
      _showCreatedState(post);
    } catch (e) {
      _showEditingErrorState();
    }
  }

  Stream<CommentState> _delete(String id) async* {
    try {
      _showDeletingState();
      await commentRepository.delete(id);
      _showDeletedState(id);
    } catch (e) {
      _showDeletingErrorState();
    }
  }
}
