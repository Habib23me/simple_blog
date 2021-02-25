import 'dart:convert';

import 'package:simple_blog/simple_blog.dart';

class Comment extends Model {
  final String id;
  final String content;
  final DateTime createdAt;
  final User user;
  Comment({
    this.id,
    this.content,
    this.createdAt,
    this.user,
  });

  Comment copyWith({
    String id,
    String content,
    DateTime createdAt,
    User user,
  }) {
    return Comment(
      id: id ?? this.id,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      user: user ?? this.user,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'user': user?.toMap(),
    };
  }

  static Comment fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Comment(
      id: map['id'],
      content: map['content'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      user: User.fromMap(map['user']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Comment.fromJson(String source) =>
      Comment.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Comment(id: $id, content: $content, createdAt: $createdAt, user: $user)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Comment &&
        o.id == id &&
        o.content == content &&
        o.createdAt == createdAt &&
        o.user == user;
  }

  @override
  int get hashCode {
    return id.hashCode ^ content.hashCode ^ createdAt.hashCode ^ user.hashCode;
  }
}
