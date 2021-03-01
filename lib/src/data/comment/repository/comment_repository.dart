import 'package:simple_blog/simple_blog.dart';
import 'package:meta/meta.dart';

class CommentRepository {
  final CommentRemoteSource remoteSource;
  CommentRepository({@required this.remoteSource})
      : assert(remoteSource != null);

  Future<Paginated<Comment>> read(int page, String postId) =>
      remoteSource.read(page, postId);
  Future<Comment> create(String comment, String postId) =>
      remoteSource.create(comment, postId);
  Future<Comment> edit(String id, String comment) =>
      remoteSource.edit(id, comment);
  Future<void> delete(String id) => remoteSource.delete(id);
}
