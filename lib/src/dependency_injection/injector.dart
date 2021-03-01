import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:simple_blog/simple_blog.dart';

final getIt = GetIt.instance;

class DependencyInjector {
  static Future<void> injectAll() async {
    await _injectLibraries();
    await _injectFeedModule();
    await _injectCommentModule();
  }

  static _injectLibraries() {
    getIt.registerSingleton(
      Dio(BaseOptions(baseUrl: "http://192.168.1.2:4000/v1"))
        ..interceptors.addAll(
          _netowrkInterceptors(),
        ),
    );
    getIt.registerSingleton(HttpAdapter(getIt()));
  }

  static _injectFeedModule() {
    getIt.registerSingleton(FeedRemoteSource(httpAdapter: getIt()));

    getIt.registerSingleton(FeedRepository(remoteSource: getIt()));
    getIt.registerFactory(() => FeedBloc(feedRepository: getIt()));
  }

  static _injectCommentModule() {
    getIt.registerSingleton(CommentRemoteSource(httpAdapter: getIt()));

    getIt.registerSingleton(CommentRepository(remoteSource: getIt()));
    getIt.registerFactory(() => CommentBloc(commentRepository: getIt()));
  }
}

Iterable<Interceptor> _netowrkInterceptors() {
  return [
    // AuthInterceptor(getIt()),
    FormDataInterceptor(),
    // BaseUrlInterceptor(),
  ];
}
