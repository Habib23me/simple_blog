import 'package:flutter/material.dart';

class SignUpPayload extends ChangeNotifier {
  String name;
  String email;
  String password;

  SignUpPayload({
    this.name,
    this.email,
    this.password,
  });

  SignUpPayload copyWith({
    String name,
    String email,
    String password,
  }) {
    return SignUpPayload(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
    };
  }

  factory SignUpPayload.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return SignUpPayload(
      name: map['name'],
      email: map['email'],
      password: map['password'],
    );
  }

  @override
  String toString() =>
      'SignUpPayload(name: $name, email: $email, password: $password)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is SignUpPayload &&
        o.name == name &&
        o.email == email &&
        o.password == password;
  }

  @override
  int get hashCode => name.hashCode ^ email.hashCode ^ password.hashCode;
}
