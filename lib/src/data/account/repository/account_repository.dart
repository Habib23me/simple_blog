import 'package:meta/meta.dart';
import 'package:simple_blog/simple_blog.dart';

class AccountRepository {
  final AccountRemoteSource remoteSource;
  final AccountLocalSource localSource;

  AccountRepository({
    @required this.remoteSource,
    @required this.localSource,
  });

  Future<void> signUp({
    String email,
    String password,
    String fullName,
  }) async {
    String token = await remoteSource.signUp(
      email: email,
      password: password,
      fullName: fullName,
    );
    return _saveToken(token);
  }

  Future<void> signIn({
    String email,
    String password,
  }) async {
    String token = await remoteSource.signIn(
      email: email,
      password: password,
    );
    return _saveToken(token);
  }

  Future<void> _saveToken(String token) {
    return localSource.write(token);
  }

  Future<void> isSignedIn() async => (await localSource.read()) != null;

  Future<void> signOut() => localSource.delete();
}
