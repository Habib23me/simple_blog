import 'package:dio/dio.dart';
import 'package:simple_blog/simple_blog.dart';

typedef NetworkProgressCallback = void Function(int count, int total);

class HttpAdapter {
  final Dio _dio;

  const HttpAdapter(this._dio) : assert(_dio != null);

  Future<T> delete<T>(
    String path, {
    data,
    int sendTimeout,
    int receiveTimeout,
    Map<String, dynamic> headers,
    Map<String, dynamic> queryParameters,
  }) {
    final options = Options(
      sendTimeout: sendTimeout,
      receiveTimeout: receiveTimeout,
      headers: headers == null ? {} : Map.from(headers),
    );
    final request = _dio.delete(
      path,
      data: data,
      options: options,
      queryParameters: queryParameters,
    );
    return _mapDioRequestToResponse<T>(request);
  }

  Future<T> deleteUri<T>(
    Uri uri, {
    data,
    int sendTimeout,
    int receiveTimeout,
    Map<String, dynamic> headers,
  }) {
    final options = Options(
      sendTimeout: sendTimeout,
      receiveTimeout: receiveTimeout,
      headers: headers == null ? {} : Map.from(headers),
    );
    final request = _dio.deleteUri(uri, data: data, options: options);
    return _mapDioRequestToResponse<T>(request);
  }

  Future<T> get<T>(
    String path, {
    int sendTimeout,
    int receiveTimeout,
    Map<String, dynamic> headers,
    Map<String, dynamic> queryParameters,
    NetworkProgressCallback onReceiveProgress,
  }) {
    final options = Options(
      sendTimeout: sendTimeout,
      receiveTimeout: receiveTimeout,
      headers: headers == null ? {} : Map.from(headers),
    );
    final request = _dio.get(
      path,
      options: options,
      queryParameters: queryParameters,
      onReceiveProgress: onReceiveProgress,
    );
    return _mapDioRequestToResponse<T>(request);
  }

  Future<T> getUri<T>(
    Uri uri, {
    int sendTimeout,
    int receiveTimeout,
    Map<String, dynamic> headers,
    NetworkProgressCallback onReceiveProgress,
  }) {
    final options = Options(
      sendTimeout: sendTimeout,
      receiveTimeout: receiveTimeout,
      headers: headers == null ? {} : Map.from(headers),
    );
    final request = _dio.getUri(
      uri,
      options: options,
      onReceiveProgress: onReceiveProgress,
    );
    return _mapDioRequestToResponse<T>(request);
  }

  Future<T> patch<T>(
    String path, {
    data,
    int sendTimeout,
    int receiveTimeout,
    Map<String, dynamic> headers,
    Map<String, dynamic> queryParameters,
    NetworkProgressCallback onSendProgress,
    NetworkProgressCallback onReceiveProgress,
  }) {
    final options = Options(
      sendTimeout: sendTimeout,
      receiveTimeout: receiveTimeout,
      headers: headers == null ? {} : Map.from(headers),
    );
    final request = _dio.patch(
      path,
      options: options,
      queryParameters: queryParameters,
      onReceiveProgress: onReceiveProgress,
    );
    return _mapDioRequestToResponse<T>(request);
  }

  Future<T> post<T>(
    String path, {
    data,
    int sendTimeout,
    int receiveTimeout,
    Map<String, dynamic> headers,
    Map<String, dynamic> queryParameters,
    NetworkProgressCallback onSendProgress,
    NetworkProgressCallback onReceiveProgress,
  }) {
    final options = Options(
      sendTimeout: sendTimeout,
      receiveTimeout: receiveTimeout,
      headers: headers == null ? {} : Map.from(headers),
    );
    final request = _dio.post(
      path,
      data: data,
      options: options,
      queryParameters: queryParameters,
    );
    return _mapDioRequestToResponse<T>(request);
  }

  Future<T> put<T>(
    String path, {
    data,
    int sendTimeout,
    int receiveTimeout,
    Map<String, dynamic> headers,
    Map<String, dynamic> queryParameters,
    NetworkProgressCallback onSendProgress,
    NetworkProgressCallback onReceiveProgress,
  }) {
    final options = Options(
      sendTimeout: sendTimeout,
      receiveTimeout: receiveTimeout,
      headers: headers == null ? {} : Map.from(headers),
    );
    final request = _dio.put(
      path,
      data: data,
      options: options,
      queryParameters: queryParameters,
    );
    return _mapDioRequestToResponse(request);
  }

  NetworkException _dioErrorToNetworkResponse(DioError error) {
    switch (error.type) {
      case DioErrorType.CONNECT_TIMEOUT:
        return NetworkException.noConnection();
      case DioErrorType.SEND_TIMEOUT:
        return NetworkException.noConnection();
      case DioErrorType.RECEIVE_TIMEOUT:
        return NetworkException.noConnection();
      case DioErrorType.RESPONSE:
        return _dioResponseToNetworkException(error.response);
      case DioErrorType.CANCEL:
        return NetworkException.canceled();
      case DioErrorType.DEFAULT:
    }
    return NetworkException.unhandled();
  }

  NetworkException _dioResponseToNetworkException(Response response) {
    if (response.statusCode == 400) {
      return NetworkException.validation(response.data);
    } else if (response.statusCode == 401) {
      return NetworkException.unauthorized();
    } else if (response.statusCode == 404) {
      return NetworkException.notFound();
    } else {
      return NetworkException.unhandled();
    }
  }

  Future<T> _mapDioRequestToResponse<T>(Future<Response> request) async {
    try {
      var response = await request;
      return response.data;
    } on DioError catch (e) {
      throw _dioErrorToNetworkResponse(e);
    }
  }
}
