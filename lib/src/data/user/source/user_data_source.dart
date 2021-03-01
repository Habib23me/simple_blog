import 'package:simple_blog/simple_blog.dart';

class UserDataSource {
  final HttpAdapter httpAdapter;

  UserDataSource({this.httpAdapter}) : assert(httpAdapter != null);

  Future<User> getUser() async {
    const path = "/users/mine";
    var map = await httpAdapter.get(path);
    return User.fromMap(map);
  }
}
