import 'package:meta/meta.dart';
import 'package:simple_blog/simple_blog.dart';

class FeedRemoteSource {
  final HttpAdapter httpAdapter;

  FeedRemoteSource({@required this.httpAdapter}) : assert(httpAdapter != null);

  Future<Paginated<Post>> read(int page) async {
    final path = "/posts?page=$page";
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
}
