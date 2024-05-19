import 'package:http/http.dart' as http;

import '../enumerations/logger_enumeration.dart';

/// The service resposible to fetch data from GitHub repository.
/// 
/// * You can check the GitHub API documentation here: https://docs.github.com/rest.
class GitHub {
  GitHub._();

  static final GitHub _instance = GitHub._();

  factory GitHub() => _instance;

  /// The repository URL, this URL can only be accessed with a token.
  static const String repository = 'https://raw.githubusercontent.com/KidGbzin/J2ME/bucket/files/';

  /// The key to access the GitHub API.
  /// 
  /// All the external games data is stored in a private repository. This repository can only be acessed via token.
  /// If the given token is wrong or does not exists, then retuns an error 404, repository not found.
  static const String token = String.fromEnvironment("TOKEN");

  /// The header for the GitHub API requests.
  /// If a request have no header the API returns an error 403, forbidden access.
  /// 
  /// All the requests made by the appliccation returns a raw MIME-type.
  static final Map<String, String> headers = <String, String> {
    "Accept": "application/json",
    "Authorization": "token $token",
    "Content-Type": "application/vnd.github.raw",
  };

  /// Fetch the data from the GitHub API.
  /// 
  /// This method returns a reponse if the data is fetched correctly, in other words if returs status code 200, successfull.
  /// If not, throw an exception based on the error code.
  static Future<http.Response> fetch(String source) async {
    http.Response response = await http.get(
      Uri.parse('$repository$source'),
      headers: headers,
    );
    if (response.statusCode == 200) {
      Logger.success.log('GitHub | ${response.statusCode}: $source');
      return response;
    }
    else {
      Logger.warning.log('GitHub | ${response.statusCode}: $source');
      if (response.statusCode == 401) throw 'Sorry, the server runned out the requests, please try again later.';
      if (response.statusCode == 404) throw 'Sorry, unable to find the "$source" file.';
      throw 'Sorry, the server returned error ${response.statusCode}.';
    }
  }

  /// Get a raw file from the API using a [source].
  /// 
  /// The bucket stores files based on the extension type.
  /// For example, a .PNG file is saved in the PNGs folder, a .RTX file is saved in the RTXs folder, and so on.
  /// 
  /// For .JAR files, there is a subfolder with the name of the game as "JARs/Gangstar - Crime City".
  /// So remember to pass the name of the subfolder as well with the .JAR file.
  static Future<http.Response> get(String source) async {
    source = source.replaceAll(':', ' -'); // Replaces the ':' caracter to ' -', because is a forbidden caracter on file systems.
    final String extension = source.split('.').last.toUpperCase();
    final http.Response response = await GitHub.fetch('${extension}s/$source');
    return response;
  }
}