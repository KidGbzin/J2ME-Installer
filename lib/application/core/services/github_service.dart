import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

import '../enumerations/logger_enumeration.dart';
import '../interfaces/bucket_interface.dart';

class GitHub implements IGitHub {

  /// The headers for the GitHub API requests.
  /// 
  /// If a request lacks headers, the API returns an error 403 (forbidden access).
  /// All requests made by the application return a raw MIME type.
  static final Map<String, String> _headers = <String, String> {
    "Accept": "application/json",
    "Authorization": "token $_token",
    "Content-Type": "application/vnd.github.raw",
  };

  /// The key to access the GitHub API.
  /// 
  /// All external game data is stored in a private repository.
  /// This repository can only be accessed via a token.
  /// If the provided token is incorrect or does not exist, an error 404 (repository not found) will be returned.
  static const String _token = String.fromEnvironment("TOKEN");


  @override
  Future<Uint8List> fetch(String source) async {
    http.Response response = await http.get(
      Uri.parse('https://raw.githubusercontent.com/KidGbzin/J2ME/bucket/files/$source'),
      headers: _headers,
    );
    if (response.statusCode == HttpStatus.ok) {
      Logger.success.log('GitHub • ${response.statusCode} | The file "$source" was successfully fetched.');
      return response.bodyBytes;
    }
    else {
      Logger.warning.log('GitHub • ${response.statusCode} | The file "$source" couldn\'t be fetched.');
      throw Exception();
    }
  }
}