import 'package:practise_app/core/utils/result.dart';

/// Base contract for all use cases in the application.
/// Ensures single responsibility and consistent invocation pattern.
abstract interface class UseCase<Type, Params> {
  Future<Result<Type>> call(Params params);
}

/// Use this when a use case does not accept any parameters.
class NoParams {
  const NoParams();
}
