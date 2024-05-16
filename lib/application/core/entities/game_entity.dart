import '../entities/jar_entity.dart';

/// The entity resposible for the game information.
class Game {

  Game({
    required this.description,
    required this.jars,
    required this.release,
    required this.tags,
    required this.title,
    required this.vendor,
  });

  /// A brief piece of information about the game.
  final String? description;

  /// A list of all [JAR] files available for this game.
  final List<JAR> jars;

  /// The year the year when the game was released.
  final int release;

  /// A list of game caracteristcs such as Action, Shooter, Sports...
  final List<String> tags;

  /// Self-explanatory, just the game's title.
  final String title;

  /// Is the name of the company that released the game.
  final String vendor;

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