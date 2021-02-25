import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:simple_blog/simple_blog.dart';

class AuthInterceptor extends Interceptor {
  final AccountLocalSource accountLocalSource;

  AuthInterceptor({@required this.accountLocalSource})
      : assert(accountLocalSource != null);

  @override
  Future onRequest(RequestOptions options) async {
    final authToken = await accountLocalSource.read();
    if (authToken != null) {
      options.headers['Authorization'] = 'Bearer $authToken';
    }
    return options;
  }
}
