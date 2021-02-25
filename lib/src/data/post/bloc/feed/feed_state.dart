part of 'feed_bloc.dart';

enum FeedStatus {
  initial,
  loading,
  loaded,
  loadingError,
  creating,
  created,
  creatingError,
}

@immutable
class FeedState extends Equatable {
  final FeedStatus feedStatus;
  final List<Post> feed;

  FeedState(this.feedStatus, {this.feed = const []});

  @override
  List<Object> get props => [feedStatus];

  FeedState copyWith(
    FeedStatus feedStatus, {
    List<Post> feed,
  }) {
    return FeedState(
      feedStatus ?? this.feedStatus,
      feed: feed ?? this.feed,
    );
  }
}
