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
    if (response.statusCode == 200) Logger.success.log('GitHub | ${response.statusCode}: $source');
    if (response.statusCode != 200) Logger.error.log('GitHub | ${response.statusCode}: $source');
    return response;
  }

  static Future<http.Response> getJAR(String source) async {
    final http.Response response = await GitHub.fetch('JARs/$source');
    return response;
  }

  static Future<http.Response> getPNG(String source) async {
    final http.Response response = await GitHub.fetch('PNGs/$source');
    return response;
  }

  static Future<http.Response> getRTX(String source) async {
    final http.Response response = await GitHub.fetch('RTXs/$source');
    return response;
  }
}