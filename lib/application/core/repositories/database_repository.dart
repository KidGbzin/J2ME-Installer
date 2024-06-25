import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../entities/game_entity.dart';

import '../interfaces/database_interface.dart';

import '../interfaces/favorites_interface.dart';
import '../interfaces/games_interface.dart';
import '../services/github_service.dart';

class Database implements IDatabase {

  late final Box<Game> _favorites;
  late final Box<Game> _games;

  @override
  Future<void> initialize() async {
    final Directory? directory = await getExternalStorageDirectory();

    Hive.defaultDirectory = directory!.path;

    Hive.registerAdapter('Game', Game.fromJson);

    _games = Hive.box<Game>(
      maxSizeMiB: 5,
      name: 'GAMES',
    );
    _favorites = Hive.box<Game>(
      maxSizeMiB: 5,
      name: 'FAVORITES',
    );

    await _fetch();
  }
  
  @override
  IFavorites get favorites => _Favorites(_favorites);
  
  @override
  IGames get games => _Games(_games);

  /// Fetch the API database and update the local database with it.
  Future<void> _fetch() async {
    _games.clear();
    final Uint8List response = await GitHub().fetch('DATABASE.json');
    final List<Game> collection = Game.all(utf8.decode(response));

    for (int index = 0; index < collection.length; index++) {
      final Game game = collection[index];
      final String key = collection[index].title;
      
      _games.put(key, game);
    }
  }
}

class _Favorites implements IFavorites {

  const _Favorites(this._box);

  final Box<Game> _box;

  @override
  bool contains(Game game) => _box.containsKey(game.title);

  @override
  void delete(Game game) => _box.delete(game.title);

  @override
  Game? fromIndex(int index) => _box[index];

  @override
  int get length => _box.length;

  @override
  void put(Game game) => _box.put(game.title, game);
}

class _Games implements IGames {

  const _Games(this._box);

  final Box<Game> _box;

  @override
  Game? fromIndex(int index) => _box[index];

  @override
  int get length => _box.length;

  @override
  Game? get(String title) => _box.get(title);
}