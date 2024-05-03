import 'dart:convert';

import 'package:http/http.dart';

import '../entities/game_entity.dart';
import '../services/github_service.dart';

/// The repository responsible to handle the data related to a [Game].
class Repository {
  static List<Game> collection = [];

  /// Fetch the API from the repository then transform into a [List] of [Game].
  static Future<void> fetch() async {
    final Response response = await GitHub.fetch('API.json');
    final String body = response.body;
    final List<dynamic> decoded = jsonDecode(body);
    collection = decoded.map(Game.fromJson).toList();
  }
}