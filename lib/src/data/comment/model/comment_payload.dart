import 'package:equatable/equatable.dart';

class CommentPayload extends Equatable {
  final String postId;
  final String comment;
  CommentPayload({this.postId, this.comment});

  CommentPayload copyWith({
    String postId,
    String comment,
  }) {
    return CommentPayload(
      postId: postId ?? this.postId,
      comment: comment ?? this.comment,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'content': comment,
      'postId': postId,
    };
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [comment, postId];
}
