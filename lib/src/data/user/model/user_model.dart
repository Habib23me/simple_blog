import 'package:equatable/equatable.dart';
import 'package:simple_blog/simple_blog.dart';

class User extends Equatable {
  final String id;
  final String username;
  final String name;
  final String profilePic;
  final String bio;
  final int posts;
  final int followers;
  final int following;
  User({
    this.id,
    this.username,
    this.name,
    this.profilePic,
    this.bio,
    this.posts,
    this.followers,
    this.following,
  });

  User copyWith({
    String id,
    String username,
    String name,
    String profilePic,
    String bio,
    int posts,
    int followers,
    int following,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      name: name ?? this.name,
      profilePic: profilePic ?? this.profilePic,
      bio: bio ?? this.bio,
      posts: posts ?? this.posts,
      followers: followers ?? this.followers,
      following: following ?? this.following,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'username': username,
      'name': name,
      'profilePic': profilePic,
      'bio': bio,
      'posts': posts,
      'followers': followers,
      'following': following,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return User(
      id: map['_id'],
      username: map['username'],
      name: map['name'],
      profilePic: '${ImageUrl.baseImageUrl}${map['profilePic']}',
      bio: map['bio'],
      posts: map['posts'],
      followers: map['followers'],
      following: map['following'],
    );
  }

  @override
  String toString() {
    return 'User(id: $id, username: $username, name: $name, profilePic: $profilePic, bio: $bio, posts: $posts, followers: $followers, following: $following)';
  }

  @override
  List<Object> get props => [
        id,
        username,
        name,
        profilePic,
        bio,
        posts,
        followers,
        following,
      ];
}
