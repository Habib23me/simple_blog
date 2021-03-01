import 'dart:convert';

import 'package:simple_blog/simple_blog.dart';

class Comment extends Model {
  final String id;
  final String content;
  final String postId;
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
    String postId,
    DateTime createdAt,
    User user,
  }) {
    return Comment(
      id: id ?? this.id,
      content: content ?? this.content,
      postId: postId ?? this.postId,
      createdAt: createdAt ?? this.createdAt,
      user: user ?? this.user,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
      'postId': postId,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'user': user?.toMap(),
    };
  }

  static Comment fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Comment(
      id: map['_id'],
      content: map['content'],
      postId: map['postId'],
      createdAt: DateTime.parse(map['created_at']),
      user: User.fromMap(map['user']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Comment.fromJson(String source) =>
      Comment.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Comment(id: $id, content: $content,postId:$postId, createdAt: $createdAt, user: $user)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Comment &&
        o.id == id &&
        o.content == content &&
        o.postId == postId &&
        o.createdAt == createdAt &&
        o.user == user;
  }

  @override
  int get hashCode {
    return id.hashCode ^ content.hashCode ^ createdAt.hashCode ^ user.hashCode;
  }
}
