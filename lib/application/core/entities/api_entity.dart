import 'dart:convert';

/// The entity responsible for the API information.
class API {
  API({
    required this.lastUpdated,
    required this.version,
  });

  /// When the API was last updated.
  /// 
  /// This parameter changes when any files are updated in the bucket.
  final DateTime lastUpdated;

  /// The atual application version.
  final String version;

  /// Convert a JSON into a [API] object.
  /// 
  /// The parameter [body] is the JSON body to be converted into a [API].
  factory API.parse(String body) {
    final Map<String, dynamic> object = jsonDecode(body);
    return API(
      lastUpdated: DateTime.parse(object['lastUpdated'] as String),
      version: object['version'] as String,
    );
  }
}