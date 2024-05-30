/// The entity responsible for the .JAR file information.
class MIDlet {
  MIDlet({
    required this.brand,
    required this.file,
    required this.isComplete,
    required this.isTouchscreen,
    required this.languages,
    required this.resolution,
    required this.size,
    required this.title,
    required this.version,
  });

  final String brand;

  /// Is the name of the [MIDlet] file with the extension .JAR.
  final String file;

  /// In J2ME a single game can have various versions depending on the device.
  /// This version can totally change the game, some have some cut levels or changes between 3D to 2D.
  /// So this boolean says this [MIDlet] is a full version of the game, usually a Sony Ericsson device.
  /// Only one file per game is a complete [MIDlet].
  final bool isComplete;

  /// A boolean to show if the [MIDlet] supports touchscreen input.
  final bool isTouchscreen;

  /// A list of all languages codes supported from the [MIDlet] file.
  final List<String> languages;

  /// It's the resolution of the game in pixels.
  final String resolution;

  /// The package size in kilobytes.
  final int size;

  /// Self-explanatory, just the game's title.
  final String title;

  /// The [MIDlet] release version.
  final String version;

  /// Convert a JSON into a [MIDlet] object.
  /// 
  /// The parameter [object] is the JSON dynamic object to be converted into a [MIDlet].
  factory MIDlet.fromJson(dynamic object) {
    return MIDlet(
      brand: object['brand'] as String,
      file: object['file'] as String,
      isComplete: object['isComplete'] as bool,
      isTouchscreen: object['isTouchscreen'] as bool,
      languages: List<String>.from(object["languages"].map((element) => element)),
      resolution: object['resolution'] as String,
      size: object['size'] as int,
      title: object['title'] as String,
      version: object['version'] as String,
    );
  }

  /// Export the [MIDlet] object to a JSON string.
  /// 
  /// This method is required to Hive write and read the object's data.
  Map<String, dynamic> toJson() {
    return <String, dynamic> {
      'brand': brand,
      'file': file,
      'isComplete': isComplete,
      'isTouchscreen': isTouchscreen,
      'languages': languages,
      'resolution': resolution,
      'size': size,
      'title': title,
      'version': version,
    };
  }
}