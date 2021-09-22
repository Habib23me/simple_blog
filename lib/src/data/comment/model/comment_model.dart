import 'package:equatable/equatable.dart';
import 'package:simple_blog/simple_blog.dart';

class Comment extends Equatable implements Model {
  final String id;
  final String content;
  final int postId;
  final DateTime createdAt;
  final User user;

  Comment({
    this.id,
    this.content,
    this.postId,
    this.createdAt,
    this.user,
  });

  Comment copyWith({
    String id,
    String content,
    int postId,
    DateTime createdAt,
    DateTime updateddAt,
    User user,
  }) {
    return Comment(
      id: id ?? this.id,
      content: content ?? this.content,
      postId: postId ?? this.postId,
      user: user ?? this.user,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'content': content,
      'postId': postId,
      'created_at': createdAt?.toIso8601String(),
      'user': user?.toMap(),
    };
  }

  static Comment fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Comment(
      id: map['_id'],
      content: map['content'],
      postId: map['postI'],
      createdAt:
          map['created_at'] != null ? DateTime.parse(map['created_at']) : null,
      user: map['user'] != null ? User.fromMap(map['user']) : null,
    );
  }

  @override
  List<Object> get props => [
        id,
        content,
        postId,
        createdAt,
        user,
      ];
}
