abstract class IException implements Exception {
  final String message;
  final StackTrace? stacktrace;

  IException({
    required this.message,
    this.stacktrace,
  });

  @override
  String toString() {
    return '\n  message: $message,\n  stacktrace: $stacktrace,\n';
  }
}