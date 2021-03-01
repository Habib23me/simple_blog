part of 'feed_bloc.dart';

mixin _ReadMixin on Bloc<FeedEvent, FeedState> {
  Stream<FeedState> _showLoadingState() async* {
    yield state.copyWith(FeedStatus.loading);
  }

  Stream<FeedState> _showLoadingError() async* {
    yield state.copyWith(FeedStatus.loadingError);
  }

  @protected
  Stream<FeedState> _showLoadedState(List<Post> feed,
      {bool shouldReload = true}) async* {
    if (shouldReload) {
      yield state.copyWith(
        FeedStatus.loaded,
        feed: feed,
      );
    } else {
      yield state.copyWith(
        FeedStatus.loaded,
        feed: List.from(state.feed)..addAll(feed),
      );
    }
  }
}
mixin _CreateMixin on Bloc<FeedEvent, FeedState> {
  Stream<FeedState> _showCreatingState() async* {
    yield state.copyWith(FeedStatus.creating);
  }

  Stream<FeedState> _showCreatingErrorState() async* {
    yield state.copyWith(FeedStatus.creatingError);
  }

  @protected
  Stream<FeedState> _showCreatedState(Post post) async* {
    yield state.copyWith(
      FeedStatus.created,
      feed: List.from(state.feed)..insert(0, post),
    );
  }
}
