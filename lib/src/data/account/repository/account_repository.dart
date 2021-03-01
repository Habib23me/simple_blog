import 'package:meta/meta.dart';
import 'package:simple_blog/simple_blog.dart';

class AccountRepository {
  final AccountRemoteSource remoteSource;
  final AccountLocalSource localSource;

  AccountRepository({
    @required this.remoteSource,
    @required this.localSource,
  });

  Future<void> signUp(SignUpPayload signUpPayload) async {
    String token = await remoteSource.signUp(signUpPayload);

    return _saveToken(token);
  }

  Future<void> signIn(SignInPayload signInPayload) async {
    String token = await remoteSource.signIn(signInPayload);
    return _saveToken(token);
  }

  Future<void> _saveToken(String token) {
    return localSource.write(token);
  }

  Future<bool> isSignedIn() async => (await localSource.read()) != null;

  Future<void> signOut() async {
    await localSource.delete();
  }
}
