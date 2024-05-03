import '../entities/jar_entity.dart';

/// The entity resposible for the game information.
/// 
/// The parameter [description] is a brief piece of information about the game. It is of type [String]. \
/// The parameter [jars] is a list of all .JARs available for download. It is a [List] of type [JAR]. \
/// The parameter [release] is the year when the game was released. It is of type [int]. \
/// The parameter [tags] is a list of game caracteristcs. It is a [List] of type [String]. \
/// The parameter [title] is self-explanatory, just the game's title. It is of type [String]. \
/// The parameter [vendor] is the name of the company that released the game. It is of the type [String].
class Game {
  final String? description;
  final List<JAR> jars;
  final int release;
  final List<String> tags;
  final String title;
  final String vendor;

  Game({
    required this.description,
    required this.jars,
    required this.release,
    required this.tags,
    required this.title,
    required this.vendor,
  });

  /// Convert a JSON into a [Game] object.
  /// 
  /// The parameter [object] is the JSON dynamic object to be converted into a [Game].
  factory Game.fromJson(dynamic object) {
    return Game(
      description: object['description'] as String?,
      jars: List<JAR>.from(object["jars"].map((element) => JAR.fromJson(element))),
      release: object['release'] as int,
      tags: List<String>.from(object["tags"].map((element) => element)),
      title: object['title'] as String,
      vendor: object['vendor'] as String,
    );
  }
}