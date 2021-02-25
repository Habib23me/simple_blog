import 'package:meta/meta.dart';
import 'package:simple_blog/simple_blog.dart';

class FeedRepository {
  final FeedRemoteSource remoteSource;

  FeedRepository({@required this.remoteSource}) : assert(remoteSource != null);

  Future<Paginated<Post>> read(int page) => remoteSource.read(page);

  Future<void> unlike(String id) => remoteSource.unlike(id);

  Future<void> like(String id) => remoteSource.like(id);

  Future<Post> create(PostPayload postPayload)=>remoteSource.create(postPayload);
}
