import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:simple_blog/simple_blog.dart';
import 'package:simple_blog/src/data/account/bloc/sign_in/sign_in_bloc.dart';
import 'package:simple_blog/src/data/account/bloc/sign_up/sign_up_bloc.dart';

final getIt = GetIt.instance;

class DependencyInjector {
  static Future<void> injectAll() async {
    await _injectLibraries();
    await _injectAccountModule();
    await _injectPostModule();
    await _injectUserModule();
  }

  static _injectLibraries() {
    getIt.registerSingleton(SecureStorage(storage: FlutterSecureStorage()));
    getIt.registerSingleton(AccountLocalSource(secureStorage: getIt()));
    getIt.registerSingleton(
      Dio(BaseOptions(baseUrl: "https://simple-feed-prod.herokuapp.com/v1"))
        ..interceptors.addAll(
          _netowrkInterceptors(),
        ),
    );

    getIt.registerSingleton(HttpAdapter(getIt()));
  }

  static _injectAccountModule() {
    getIt.registerSingleton(AccountRemoteSource(httpAdapter: getIt()));
    getIt.registerSingleton(
        AccountRepository(remoteSource: getIt(), localSource: getIt()));
    getIt.registerFactory(() => AuthenticationBloc(accountRepository: getIt()));
    getIt.registerFactory(() => SignInBloc(accountRepository: getIt()));
    getIt.registerFactory(() => SignUpBloc(accountRepository: getIt()));
  }

  static _injectPostModule() {
    getIt.registerSingleton(PostRemoteSource(httpAdapter: getIt()));
    getIt.registerSingleton(PostRepository(remoteSource: getIt()));
    getIt.registerFactory(() => FeedBloc(feedRepository: getIt()));
    getIt.registerFactory(() => UserPostsBloc(feedRepository: getIt()));
  }

  static _injectUserModule() {
    getIt.registerSingleton(UserDataSource(httpAdapter: getIt()));

    getIt.registerSingleton(UserRepository(dataSource: getIt()));
    getIt.registerFactory(() => UserBloc(userRepository: getIt()));
  }
}

Iterable<Interceptor> _netowrkInterceptors() {
  return [
    AuthInterceptor(accountLocalSource: getIt()),
    FormDataInterceptor(),
    PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
    ),
    // BaseUrlInterceptor(),
  ];
}
