import 'dart:convert';
import 'dart:io';

import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';

import '../entities/game_entity.dart';
import '../services/github_service.dart';

/// The local [Database] stored on the device.
/// 
/// It is handled by the [Hive] package using boxes.
class Database {
  Database._();

  static final Database _instance = Database._();

  factory Database() => _instance;

  /// The games collection [Box].
  /// 
  /// Stores the entire list of games.
  static late final Box<Game> games;

  /// Initialize the [Database].
  /// 
  /// Make the [Database] available to use by opening all boxes and updating data if needed.
  static Future<void> initialize() async {
    final Directory? directory = await getExternalStorageDirectory();
    Hive.defaultDirectory = directory!.path;
    Hive.registerAdapter('Game', Game.fromJson);
    games = Hive.box<Game>(
      maxSizeMiB: 5,
      name: 'API',
    );
    await _fetchAPI();
  }

  /// Update the [games] collection from API.
  static Future<void> _fetchAPI() async {
    final Response response = await GitHub.fetch('API.json');
    final List decoded = jsonDecode(response.body);
    final List<Game> collection = decoded.map(Game.fromJson).toList();
    for (int index = 0; index < collection.length; index++) {
      final Game game = collection[index];
      final String key = collection[index].title;
      games.put(key, game);
    }
  }
}