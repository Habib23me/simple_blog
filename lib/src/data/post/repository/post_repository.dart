import 'package:meta/meta.dart';
import 'package:simple_blog/simple_blog.dart';

class PostRepository {
  final PostRemoteSource remoteSource;

  PostRepository({@required this.remoteSource}) : assert(remoteSource != null);

  Future<Paginated<Post>> read(int page) => remoteSource.read(page);
  Future<Paginated<Post>> readUserPosts(int page) =>
      remoteSource.readUserPosts(page);

  Future<void> unlike(String id) => remoteSource.unlike(id);

  Future<void> like(String id) => remoteSource.like(id);

  Future<Post> create(PostPayload postPayload) =>
      remoteSource.create(postPayload);

  Future<Post> edit(String postId, String caption) =>
      remoteSource.edit(postId, caption);

  Future<void> delete(
    String postId,
  ) =>
      remoteSource.delete(
        postId,
      );
}
