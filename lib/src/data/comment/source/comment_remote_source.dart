import 'package:meta/meta.dart';
import 'package:simple_blog/simple_blog.dart';
import 'package:simple_blog/src/data/comment/model/comment_model.dart';
import 'package:simple_blog/src/data/comment/model/model.dart';

class CommentRemoteSource {
  final HttpAdapter httpAdapter;

  CommentRemoteSource({@required this.httpAdapter})
      : assert(httpAdapter != null);

  Future<Paginated<Comment>> readComments(String postId, int page) async {
    final path = "/comments/post/$postId?page=$page";
    var response = await httpAdapter.get<Map>(path);

    return Paginated.fromMap(response, Comment.fromMap);
  }

  Future<Comment> create(CommentPayload commentPayload) async {
    print('${commentPayload.comment} yodi');
    final path = "/comments";
    final response = await httpAdapter.post<Map>(
      path,
      data: commentPayload.toMap(),
    );
    return Comment.fromMap(response);
  }

  Future<Comment> edit(String commentId, String comment) async {
    final path = "/comments/$commentId";
    final response =
        await httpAdapter.put<Map>(path, data: {"caption": comment});
    return Comment.fromMap(response);
  }

  Future<void> delete(String commentId) async {
    final path = "/comments/$commentId";
    return httpAdapter.delete(path);
  }
}
