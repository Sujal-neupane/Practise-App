/// Base exception for all app-level exceptions
class AppException implements Exception {
  final String message;
  final int? statusCode;

  const AppException({required this.message, this.statusCode});

  @override
  String toString() => 'AppException(message: $message, statusCode: $statusCode)';
}

/// Thrown when a remote server error occurs (e.g. 500, 404, bad gateway)
class ServerException extends AppException {
  const ServerException({required super.message, super.statusCode});
}

/// Thrown when local cache read/write operations fail (e.g. SQLite, Hive, Shared Preferences)
class CacheException extends AppException {
  const CacheException({required super.message, super.statusCode});
}

/// Thrown when there is no internet connection or a timeout occurs
class NetworkException extends AppException {
  const NetworkException({required super.message, super.statusCode});
}

/// Thrown when an authentication or unauthorized error occurs (e.g. 401)
class UnauthorizedException extends AppException {
  const UnauthorizedException({super.message = 'Unauthorized access', super.statusCode = 401});
}
