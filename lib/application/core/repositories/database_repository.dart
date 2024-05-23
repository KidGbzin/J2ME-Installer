import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';

import '../entities/api_entity.dart';
import '../entities/game_entity.dart';
import '../enumerations/logger_enumeration.dart';
import '../services/github_service.dart';

/// The local [Database] stored on the device.
/// 
/// It is handled by the [Hive] package using boxes.
class Database {
  Database._();

  static final Database _instance = Database._();

  factory Database() => _instance;

  static late final DateTime lastCheck;
  static late final DateTime lastUpdated;

  /// The games collection [Box].
  /// 
  /// Stores the entire list of games.
  static late final Box<Game> games;

  /// The local configuration [Box].
  /// 
  /// All cached settings will be stored here. This [Box] includes:
  /// 
  /// `lastCheck`: When the API file was last checked; \
  /// `lastUpdated`: When the API bucket was last updated.
  static late final Box<dynamic> settings;

  /// Initialize the [Database].
  /// 
  /// Make the [Database] available to use by opening all boxes and updating data if needed.
  static Future<void> initialize() async {
    final Directory? directory = await getExternalStorageDirectory();

    Hive.defaultDirectory = directory!.path;

    Hive.registerAdapter('Game', Game.fromJson);

    games = Hive.box<Game>(
      maxSizeMiB: 5,
      name: 'DATABASE',
    );
    settings = Hive.box<dynamic>(
      maxSizeMiB: 5,
      name: 'SETTINGS',
    );

    lastCheck = DateTime.tryParse(settings.get("lastCheck") ?? "") ?? DateTime(1970);
    lastUpdated = DateTime.tryParse(settings.get("lastUpdated") ?? "") ?? DateTime(1970);

    _checkAPI();
  }

  /// Fetch the API database and update the local database with it.
  static Future<void> _fetchAndUpdateDatabase() async {
    final Response response = await GitHub.fetch('DATABASE.json');
    final List<Game> collection = Game.all(response.body);

    for (int index = 0; index < collection.length; index++) {
      final Game game = collection[index];
      final String key = collection[index].title;
      games.put(key, game);
    }
  }

  /// Ckecks if the API needs to be updated.
  /// 
  /// The [API] is checked from source once per day.
  /// When the [API] is out of date fetch the data and update the database.
  static Future<void> _checkAPI() async {
    final DateTime actualTime = DateTime.now();
    final bool isSameDay =  DateUtils.isSameDay(actualTime, lastCheck);
    if (isSameDay) {
      Logger.information.log("Database • Hive | The API has already been checked today!");
    }
    else {
      final Response response = await GitHub.fetch("API.json");
      final API api = API.parse(response.body);
      final bool isUpToDate = api.lastUpdated.isAfter(lastUpdated);
      if (isUpToDate) {
        Logger.information.log("Database • Hive | The local database is up to date!");
      }
      else {
        _fetchAndUpdateDatabase();
        settings.put("lastUpdated", "${DateTime.now()}");
      }
    }
    settings.put('lastCheck', "${DateTime.now()}");
  }
}