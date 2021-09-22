part of 'feed_bloc.dart';

abstract class FeedEvent {}

class ReadFeed extends FeedEvent {}

class ReloadFeed extends FeedEvent {}

class ReadNextPageFeed extends FeedEvent {}

class PostToFeed extends FeedEvent {
  final PostPayload postPayload;

  PostToFeed(this.postPayload);
}

class ToggleLike extends FeedEvent {
  final String id;

  ToggleLike(this.id);
}
