/// The entity responsible for the .JAR file information.
/// 
/// The parameter [file] is the name of the .JAR file. It's of type [String]. \
/// The parameter [isTouchscreen] tells if the .JAR has a touchscreen support. It's of the type [bool]. \
/// The parameter [language] is all of the .JAR supported languages. It's a [List] of the type [String]. \
/// The parameter [resolution] it's the resolution of the .JAR in pixels. It's of the type [String]. \
/// The parameter [size] is the file size in bytes. It's of the tpoe [int]. \
/// The parameter [title] is self-explanatory, just the game's title. It is of type [String]. \
/// The parameter [version] is the .JAR release version. It is of type [String].
class JAR {
  final String file;
  final bool isTouchscreen;
  final List<String> language;
  final String resolution;
  final int size;
  final String title;
  final String version;

  JAR({
    required this.file,
    required this.isTouchscreen,
    required this.language,
    required this.resolution,
    required this.size,
    required this.title,
    required this.version,
  });

  /// Convert a JSON into a [JAR] object.
  /// 
  /// The parameter [object] is the JSON dynamic object to be converted into a [JAR].
  factory JAR.fromJson(dynamic object) {
    return JAR(
      file: object['file'] as String,
      isTouchscreen: object['isTouchscreen'] as bool,
      language: List<String>.from(object["language"].map((element) => element)),
      resolution: object['resolution'] as String,
      size: object['size'] as int,
      title: object['title'] as String,
      version: object['version'] as String,
    );
  }
}