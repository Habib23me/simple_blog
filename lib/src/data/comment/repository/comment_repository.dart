import 'package:meta/meta.dart';
import 'package:simple_blog/simple_blog.dart';
import 'package:simple_blog/src/data/comment/model/comment_model.dart';
import 'package:simple_blog/src/data/comment/model/model.dart';
import 'package:simple_blog/src/data/comment/source/source.dart';

class CommentRepository {
  final CommentRemoteSource remoteSource;

  CommentRepository({@required this.remoteSource})
      : assert(remoteSource != null);

  Future<Paginated<Comment>> readComments(String postId, int page) =>
      remoteSource.readComments(postId, page);

  Future<Comment> create(CommentPayload commentPayload) =>
      remoteSource.create(commentPayload);

  Future<Comment> edit(String commentId, String comment) =>
      remoteSource.edit(commentId, comment);

  Future<void> delete(
    String commentId,
  ) =>
      remoteSource.delete(
        commentId,
      );
}
