import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

import '../enumerations/logger_enumeration.dart';

import '../exceptions/github_exceptions.dart';

import '../interfaces/client_interface.dart';

/// An HTTP client service to consume the GitHub API.
class GitHub implements IClient {

  /// The headers for the GitHub API requests.
  ///
  /// If a request lacks headers, the API returns an error 403 (forbidden access).
  /// All requests made on the GitHub return a raw MIME type.
  final Map<String, String> _headers = <String, String> {
    "Accept": "application/json",
    "Authorization": "token $_token",
    "Content-Type": "application/vnd.github.raw",
  };

  /// The key to access the GitHub API.
  ///
  /// All external game data is stored in a private repository.
  /// This repository can only be accessed via a token.
  /// If the provided token is incorrect or does not exist, an error [HttpStatus.notFound] will be returned.
  static const String _token = String.fromEnvironment(
    "TOKEN",
  );

  /// Fetches a file from the GitHub API as a [Uint8List].
  ///
  /// [Exception] to be handled:
  /// - `ClientException`: Thrown by the [http] package, usually when there is no connection available;
  /// - `ResponseException`: Any response that is not [HttpStatus.accepted].
  @override
  Future<Uint8List> get(String source) async {
    http.Response response = await http.get(
      Uri.parse('https://raw.githubusercontent.com/KidGbzin/J2ME/bucket/files/$source'),
      headers: _headers,
    );
    if (response.statusCode == HttpStatus.ok) {
      Logger.success.print(
        label: 'GitHub | GET • ${response.statusCode}',
        message: 'The file "$source" was successfully fetched.',
      );
      return response.bodyBytes;
    }
    else {
      Logger.warning.print(
        label: 'GitHub | GET • ${response.statusCode}',
        message: 'The file "$source" couldn\'t be fetched.',
      );
      throw ResponseException(
        message: 'The file "$source" returned an error of status code ${response.statusCode}!',
        statusCode: response.statusCode,
      );
    }
  }
}