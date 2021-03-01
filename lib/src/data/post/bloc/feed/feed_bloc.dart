import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:simple_blog/simple_blog.dart';

part 'feed_event.dart';
part 'feed_state.dart';
part 'feed_mixins.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState>
    with _ReadMixin, _CreateMixin {
  final PostRepository feedRepository;
  PageMetaData metaData;
  FeedBloc({@required this.feedRepository})
      : assert(feedRepository != null),
        super(FeedState(FeedStatus.initial));

  @override
  Stream<FeedState> mapEventToState(
    FeedEvent event,
  ) async* {
    if (event is ReadFeed) {
      yield* _showLoadingState();
      yield* _read();
    } else if (event is ReloadFeed) {
      yield* _read();
    } else if (event is ReadNextPageFeed) {
      if (metaData?.hasNextPage ?? false) {
        yield* _read(page: metaData.nextPage, shouldReload: false);
      }
    } else if (event is ToggleLike) {
      yield* _toggleLike(event.id);
    } else if (event is IncrementComment) {
      yield* _incrementComment(event.id);
    } else if (event is DecrementComment) {
      yield* _decrementComment(event.id);
    } else if (event is PostToFeed) {
      yield* _postToFeed(event.postPayload);
    }
  }

  Stream<FeedState> _read({int page = 1, bool shouldReload = true}) async* {
    try {
      var feed = await feedRepository.read(page);
      metaData = feed.metaData;
      yield* _showLoadedState(feed.docs, shouldReload: shouldReload);
    } catch (e) {
      yield* _showLoadingError();
    }
  }

  Stream<FeedState> _toggleLike(String id) async* {
    var post = state.feed.findById(id);
    if (post == null) {
      return;
    }
    var feed = state.feed.findAndReplaceById(id, post.toggleLike());
    yield* _showLoadedState(feed);

    //Make request to update status
    try {
      post.isLiked
          ? await feedRepository.unlike(id)
          : await feedRepository.like(id);
    } catch (e) {
      var feed = state.feed.findAndReplaceById(id, post.toggleLike());
      yield* _showLoadedState(feed);
    }
  }

  Stream<FeedState> _incrementComment(String id) async* {
    var post = state.feed.findById(id);
    if (post == null) {
      return;
    }
    var feed = state.feed.findAndReplaceById(id, post.incrementComment());
    yield* _showLoadedState(feed);
  }

  Stream<FeedState> _decrementComment(String id) async* {
    var post = state.feed.findById(id);
    if (post == null) {
      return;
    }
    var feed = state.feed.findAndReplaceById(id, post.incrementComment());
    yield* _showLoadedState(feed);
  }

  Stream<FeedState> _postToFeed(PostPayload postPayload) async* {
    try {
      yield* _showCreatingState();
      var post = await feedRepository.create(postPayload);
      yield* _showCreatedState(post);
    } catch (e) {
      yield* _showCreatingErrorState();
    }
  }
}
