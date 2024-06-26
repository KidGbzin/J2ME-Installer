import '../interfaces/exception_interface.dart';

class ResponseException extends IException {

  ResponseException({
    required super.message,
    super.stacktrace,
    required this.statusCode,
  });

  final int statusCode;
}