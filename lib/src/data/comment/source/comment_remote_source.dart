import 'package:meta/meta.dart';
import 'package:simple_blog/simple_blog.dart';

class CommentRemoteSource {
  final HttpAdapter httpAdapter;

  CommentRemoteSource({@required this.httpAdapter})
      : assert(httpAdapter != null);

  Future<Paginated<Comment>> read(int page) async {
    final path = "/comments?page=$page";
    final response = await httpAdapter.get<Map>(
      path,
    );
    return Paginated<Comment>.fromMap(response, Comment.fromMap);
  }

  Future<Comment> create(String comment) async {
    const path = "/comments";
    final response =
        await httpAdapter.post<Map>(path, data: {"comment": comment});
    return Comment.fromMap(response);
  }

  Future<Comment> edit(String id, String comment) async {
    final path = "/comments/$id";
    final response =
        await httpAdapter.put<Map>(path, data: {"comment": comment});
    return Comment.fromMap(response);
  }

  Future<void> delete(String id) {
    const path = "/comments";
    return httpAdapter.delete(path);
  }
}
