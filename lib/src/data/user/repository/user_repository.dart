import 'package:meta/meta.dart';
import 'package:simple_blog/simple_blog.dart';

class UserRepository {
  final UserDataSource dataSource;

  UserRepository({@required this.dataSource}) : assert(dataSource != null);

  Future<User> getUser() => dataSource.getUser();
}
