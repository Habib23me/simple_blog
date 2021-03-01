part of 'user_posts_bloc.dart';

mixin _ReadMixin on Bloc<UserPostsEvent, UserPostsState> {
  Stream<UserPostsState> _showLoadingState() async* {
    yield state.copyWith(UserPostsStatus.loading);
  }

  Stream<UserPostsState> _showLoadingError() async* {
    yield state.copyWith(UserPostsStatus.loadingError);
  }

  @protected
  Stream<UserPostsState> _showLoadedState(
    List<Post> posts, {
    bool shouldReload = true,
  }) async* {
    if (shouldReload) {
      yield state.copyWith(
        UserPostsStatus.loaded,
        posts: posts,
      );
    } else {
      yield state.copyWith(
        UserPostsStatus.loaded,
        posts: List.from(state.posts)..addAll(posts),
      );
    }
  }
}

mixin _EditMixin on Bloc<UserPostsEvent, UserPostsState> {
  Stream<UserPostsState> _showEditingState() async* {
    yield state.copyWith(UserPostsStatus.editing);
  }

  Stream<UserPostsState> _showEditingError() async* {
    yield state.copyWith(UserPostsStatus.editingError);
  }

  @protected
  Stream<UserPostsState> _showEditedState(
    Post post,
  ) async* {
    yield state.copyWith(
      UserPostsStatus.edited,
      posts: state.posts.findAndReplaceById(post.id, post),
    );
  }
}
mixin _DeleteMixin on Bloc<UserPostsEvent, UserPostsState> {
  Stream<UserPostsState> _showDeletingState() async* {
    yield state.copyWith(UserPostsStatus.deleting);
  }

  Stream<UserPostsState> _showDeletingError() async* {
    yield state.copyWith(UserPostsStatus.deletingError);
  }

  @protected
  Stream<UserPostsState> _showDeletedState(String postId) async* {
    yield state.copyWith(
      UserPostsStatus.deleted,
      posts: state.posts.findAndRemoveById(postId),
    );
  }
}
