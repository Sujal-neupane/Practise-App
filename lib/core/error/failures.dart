/// Base failure class returned across domain and presentation layers
abstract class Failure {
  final String message;
  final int? statusCode;

  const Failure({required this.message, this.statusCode});

  @override
  String toString() => '$runtimeType: $message (code: $statusCode)';
}

/// Represents failure from remote API/backend
class ServerFailure extends Failure {
  const ServerFailure({required super.message, super.statusCode});
}

/// Represents failure when accessing local database or cache
class CacheFailure extends Failure {
  const CacheFailure({required super.message, super.statusCode});
}

/// Represents failure due to offline state or network connectivity
class NetworkFailure extends Failure {
  const NetworkFailure({super.message = 'No internet connection', super.statusCode});
}

/// Represents generic or unexpected failures
class UnknownFailure extends Failure {
  const UnknownFailure({super.message = 'An unexpected error occurred', super.statusCode});
}
