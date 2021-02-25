import 'package:simple_blog/simple_blog.dart';

import 'package:meta/meta.dart';

class AccountRemoteSource {
  final HttpAdapter httpAdapter;

  AccountRemoteSource({@required this.httpAdapter})
      : assert(httpAdapter != null);

  Future<String> signUp({String email, String password, String fullName}) {
    const path = "/accounts";
    return httpAdapter.post(path, data: {
      'email': email,
      'password': password,
      'fullName': fullName,
    });
  }

  Future<String> signIn({String email, String password}) {
    const path = "/accounts";
    return httpAdapter.post(path, data: {
      'email': email,
      'password': password,
    });
  }
}
