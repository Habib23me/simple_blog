import 'package:simple_blog/simple_blog.dart';

import 'package:meta/meta.dart';

class AccountRemoteSource {
  final HttpAdapter httpAdapter;

  AccountRemoteSource({@required this.httpAdapter})
      : assert(httpAdapter != null);

  Future<String> signUp(SignUpPayload signUpPayload) async {
    const path = "/accounts/signup";
    var response = await httpAdapter.post(
      path,
      data: signUpPayload.toMap(),
    );
    return response['accessToken'];
  }

  Future<String> signIn(SignInPayload signInPayload) async {
    const path = "/accounts/signin";
    var response = await httpAdapter.post(
      path,
      data: signInPayload.toMap(),
    );
    return response['accessToken'];
  }
}
