import 'dart:typed_data';

import 'package:http/http.dart' as http;

import '../enumerations/logger_enumeration.dart';

class GitHub {
  GitHub._();

  static final GitHub _instance = GitHub._();

  factory GitHub() => _instance;

  static const String token = String.fromEnvironment("TOKEN");
  static const String repository = 'https://raw.githubusercontent.com/KidGbzin/J2ME/files/';

  static final Map<String, String> headers = <String, String> {
    "Accept": "application/json",
    "Authorization": "token $token",
    "Content-Type": "application/vnd.github.raw",
  };

  static Future<http.Response> fetch(String source) async {
    http.Response response = await http.get(
      Uri.parse('$repository$source'),
      headers: headers,
    );
    return response;
  }

  static Future<Uint8List> getFile(String source) async {
    final http.Response response = await GitHub.fetch(source);
    if (response.statusCode == 200) {
      Logger.success.log('The file "$source" has been successfully downloaded!');
      return response.bodyBytes;
    }
    Logger.error.log('The file "$source" could not be downloaded!');
    throw Exception('GitHub returned ${response.statusCode} while searching for the "$source" file.');
  }
}