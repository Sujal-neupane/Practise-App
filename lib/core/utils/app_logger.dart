import 'dart:developer' as developer;

class AppLogger {
  static void debug(String message, [String? tag]) {
    developer.log('[DEBUG] $message', name: tag ?? 'PractiseApp');
  }

  static void info(String message, [String? tag]) {
    developer.log('[INFO] $message', name: tag ?? 'PractiseApp');
  }

  static void error(String message, [dynamic error, StackTrace? stackTrace, String? tag]) {
    developer.log(
      '[ERROR] $message',
      name: tag ?? 'PractiseApp',
      error: error,
      stackTrace: stackTrace,
    );
  }
}
