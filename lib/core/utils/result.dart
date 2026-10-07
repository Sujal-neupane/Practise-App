import 'package:practise_app/core/error/failures.dart';

/// Modern Dart 3 sealed class representing either a Success or Failure outcome.
/// Provides exhaustive pattern matching:
/// ```dart
/// switch (result) {
///   case Success(:final data): print(data);
///   case FailureResult(:final failure): print(failure.message);
/// }
/// ```
sealed class Result<T> {
  const Result();

  bool get isSuccess => this is Success<T>;
  bool get isFailure => this is FailureResult<T>;

  R fold<R>({
    required R Function(Failure failure) onFailure,
    required R Function(T data) onSuccess,
  }) {
    return switch (this) {
      Success<T>(:final data) => onSuccess(data),
      FailureResult<T>(:final failure) => onFailure(failure),
    };
  }
}

final class Success<T> extends Result<T> {
  final T data;
  const Success(this.data);
}

final class FailureResult<T> extends Result<T> {
  final Failure failure;
  const FailureResult(this.failure);
}
