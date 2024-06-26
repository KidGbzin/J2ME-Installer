import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../entities/game_entity.dart';

import '../interfaces/bucket_interface.dart';
import '../interfaces/database_interface.dart';
import '../interfaces/favorites_interface.dart';
import '../interfaces/games_interface.dart';
import '../interfaces/settings_interface.dart';

class Database implements IDatabase {

  Database({
    required this.favorites,
    required this.games,
    required this.gitHub,
    required this.settings,
  });

  final IGitHub gitHub;

  @override
  late final IFavorites favorites;

  @override
  late final IGames games;

  @override
  late final ISettings settings;

  @override
  Future<void> initialize() async {
    final Directory? directory = await getExternalStorageDirectory();

    Hive.defaultDirectory = directory!.path;

    Hive.registerAdapter('Game', Game.fromJson);

    favorites.open();
    games.open();
    settings.open();
  }

  /// Fetch the API database and update the local database with it.
  Future<void> _update() async {
    final Uint8List bytes = await gitHub.fetch('DATABASE.json');
    final List<Object> decoded = jsonDecode(utf8.decode(bytes));
    final List<Game> collection = decoded.map(Game.fromJson).toList();
  
    games.clear();
    for (final Game index in collection) {
      games.put(index);
    }
  }
}