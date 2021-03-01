import 'package:meta/meta.dart';
import 'package:simple_blog/simple_blog.dart';

class CommentRemoteSource {
  final HttpAdapter httpAdapter;

  CommentRemoteSource({@required this.httpAdapter})
      : assert(httpAdapter != null);

  Future<Paginated<Comment>> read(int page, String postId) async {
    final path = "/comments/post/$postId?page=$page";
    final response = await httpAdapter.get<Map>(
      path,
    );
    return Paginated<Comment>.fromMap(response, Comment.fromMap);
  }

  Future<Comment> create(String comment, String postId) async {
    const path = "/comments";
    final response = await httpAdapter.post<Map>(path, data: {
      "content": comment,
      "postId": postId,
    });
    return Comment.fromMap(response);
  }

  Future<Comment> edit(String id, String comment) async {
    final path = "/comments/$id";
    final response =
        await httpAdapter.put<Map>(path, data: {"content": comment});
    return Comment.fromMap(response);
  }

  Future<void> delete(String id) async {
    final String path = "/comments/$id";
    return httpAdapter.delete(path);
  }
}
