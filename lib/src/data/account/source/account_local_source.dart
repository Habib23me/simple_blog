import 'package:meta/meta.dart';
import 'package:simple_blog/simple_blog.dart';

class AccountLocalSource {
  static const TOKEN_KEY = "JWT_TOKEN";
  final SecureStorage secureStorage;

  AccountLocalSource({@required this.secureStorage})
      : assert(secureStorage != null);

  Future<String> read() => secureStorage.read(TOKEN_KEY);

  Future<void> write(String value) => secureStorage.write(TOKEN_KEY, value);

  Future<void> delete() => secureStorage.delete(TOKEN_KEY);
}
