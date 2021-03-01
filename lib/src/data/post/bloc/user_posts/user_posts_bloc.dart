import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:simple_blog/simple_blog.dart';
import 'package:equatable/equatable.dart';

part 'user_posts_event.dart';
part 'user_posts_mixin.dart';
part 'user_posts_state.dart';

class UserPostsBloc extends Bloc<UserPostsEvent, UserPostsState>
    with _ReadMixin, _EditMixin, _DeleteMixin {
  PageMetaData metaData;
  final PostRepository feedRepository;
  UserPostsBloc({@required this.feedRepository})
      : assert(feedRepository != null),
        super(UserPostsState(UserPostsStatus.initial));

  @override
  Stream<UserPostsState> mapEventToState(
    UserPostsEvent event,
  ) async* {
    if (event is ReadUserPosts) {
      yield* _showLoadingState();
      yield* _read();
    } else if (event is ReloadUserPosts) {
      yield* _read();
    } else if (event is ReadNextUserPosts) {
      if (metaData?.hasNextPage ?? false) {
        yield* _read(
          page: metaData.nextPage,
          shouldReload: false,
        );
      }
    } else if (event is EditUserPost) {
      yield* _editPost(
        event.postId,
        event.caption,
      );
    } else if (event is DeleteUserPost) {
      yield* _deletePost(event.postId);
    }
  }

  Stream<UserPostsState> _read({
    int page = 1,
    bool shouldReload = true,
  }) async* {
    try {
      var posts = await feedRepository.readUserPosts(page);
      metaData = posts.metaData;
      yield* _showLoadedState(posts.docs, shouldReload: shouldReload);
    } catch (e) {
      yield* _showLoadingError();
    }
  }

  Stream<UserPostsState> _editPost(String postId, String caption) async* {
    try {
      yield* _showEditingState();
      var post = await feedRepository.edit(postId, caption);
      yield* _showEditedState(post);
    } catch (e) {
      yield* _showEditingError();
    }
  }

  Stream<UserPostsState> _deletePost(String postId) async* {
    try {
      yield* _showDeletingState();
      await feedRepository.delete(postId);
      yield* _showDeletedState(postId);
    } catch (e) {
      yield* _showDeletingError();
    }
  }
}
