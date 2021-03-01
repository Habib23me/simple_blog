import 'package:flutter/material.dart';

class SignInPayload extends ChangeNotifier {
  String email;
  String password;
  SignInPayload({
    this.email,
    this.password,
  });

  SignInPayload copyWith({
    String email,
    String password,
  }) {
    return SignInPayload(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
    };
  }

  factory SignInPayload.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return SignInPayload(
      email: map['email'],
      password: map['password'],
    );
  }

  @override
  String toString() => 'SignInPayload(email: $email, password: $password)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is SignInPayload && o.email == email && o.password == password;
  }

  @override
  int get hashCode => email.hashCode ^ password.hashCode;
}
