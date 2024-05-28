import 'package:http/http.dart' as http;

import '../enumerations/logger_enumeration.dart';

/// The service responsible for fetching data from a GitHub repository.
/// 
/// You can check the GitHub API documentation here: https://docs.github.com/rest.
class GitHub {
  /// The headers for the GitHub API requests.
  /// 
  /// If a request lacks headers, the API returns an error 403 (forbidden access).
  /// All requests made by the application return a raw MIME type.
  static final Map<String, String> headers = <String, String> {
    "Accept": "application/json",
    "Authorization": "token $token",
    "Content-Type": "application/vnd.github.raw",
  };

  /// The repository URL, which can only be accessed with a token.
  static const String repository = 'https://raw.githubusercontent.com/KidGbzin/J2ME/bucket/files/';

  /// The key to access the GitHub API.
  /// 
  /// All external game data is stored in a private repository.
  /// This repository can only be accessed via a token.
  /// If the provided token is incorrect or does not exist, an error 404 (repository not found) will be returned.
  static const String token = String.fromEnvironment("TOKEN");

  /// Fetches data from the GitHub API.
  /// 
  /// This method returns a response if the data is fetched successfully (status code 200).
  /// Otherwise, it throws an exception based on the error code.
  static Future<http.Response> fetch(String source) async {
    http.Response response = await http.get(
      Uri.parse('$repository$source'),
      headers: headers,
    );
    if (response.statusCode == 200) {
      Logger.success.log('GitHub • ${response.statusCode} | The file "$source" was successfully fetched.');
      return response;
    }
    else {
      Logger.warning.log('GitHub • ${response.statusCode} | The file "$source" couldn\'t be fetched.');
      if (response.statusCode == 401) throw 'Sorry, the server runned out the requests, please try again later.';
      if (response.statusCode == 404) throw 'Sorry, unable to find the "$source" file.';
      throw 'Sorry, the server returned error ${response.statusCode}.';
    }
  }
}