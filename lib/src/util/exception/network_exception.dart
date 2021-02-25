enum NetworkExceptionType {
  unauthorized,
  notFound,
  noConnection,
  unhandled,
  validation,
  canceled
}

class NetworkException implements Exception {
  final String message;
  final NetworkExceptionType type;

  const NetworkException(this.message, this.type);

  factory NetworkException.unauthorized() => const NetworkException(
        "You're not authorized to make this request",
        NetworkExceptionType.unauthorized,
      );
  factory NetworkException.notFound() => const NetworkException(
        "The requested data wasn't found",
        NetworkExceptionType.notFound,
      );

  factory NetworkException.noConnection() => const NetworkException(
        "There was problem connecting. Please try again",
        NetworkExceptionType.noConnection,
      );

  factory NetworkException.unhandled() => const NetworkException(
        "Something went wrong while processing the request. Please try again",
        NetworkExceptionType.unauthorized,
      );

  factory NetworkException.canceled() => const NetworkException(
        null,
        NetworkExceptionType.canceled,
      );

  factory NetworkException.validation(String message) => NetworkException(
        message,
        NetworkExceptionType.validation,
      );
}
