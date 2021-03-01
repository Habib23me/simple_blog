import 'package:meta/meta.dart';
import 'package:simple_blog/simple_blog.dart';

class PostRemoteSource {
  final HttpAdapter httpAdapter;

  PostRemoteSource({@required this.httpAdapter}) : assert(httpAdapter != null);

  Future<Paginated<Post>> read(int page) async {
    final path = "/posts?page=$page";
    var response = await httpAdapter.get<Map>(path);
    return Paginated.fromMap(response, Post.fromMap);
  }

  Future<Paginated<Post>> readUserPosts(int page) async {
    final path = "/posts/user/mine?page=$page";
    var response = await httpAdapter.get<Map>(path);
    return Paginated.fromMap(response, Post.fromMap);
  }

  Future<void> unlike(String id) async {
    final path = "/posts/unlike/$id";
    return httpAdapter.put(path);
  }

  Future<void> like(String id) {
    final path = "/posts/like/$id";
    return httpAdapter.put(path);
  }

  Future<Post> create(PostPayload postPayload) async {
    final path = "/posts";
    final response = await httpAdapter.post<Map>(
      path,
      data: postPayload.toMap(),
    );
    return Post.fromMap(response);
  }

  Future<Post> edit(String postId, String caption) async {
    final path = "/posts/$postId";
    final response =
        await httpAdapter.put<Map>(path, data: {"caption": caption});
    return Post.fromMap(response);
  }

  Future<void> delete(String postId) async {
    final path = "/posts/$postId";
    return httpAdapter.delete(path);
  }
}
