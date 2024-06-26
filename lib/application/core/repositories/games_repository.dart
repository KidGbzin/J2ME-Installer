import 'package:hive/hive.dart';

import '../entities/game_entity.dart';

import '../interfaces/games_interface.dart';

class Games implements IGames {
  late final Box<Game> _box;

  @override
  Game? fromIndex(int index) => _box[index];

  @override
  int get length => _box.length;

  @override
  Game? get(String title) => _box.get(title);
  
  @override
  void close() => _box.close();
  
  @override
  void open() {
    _box = Hive.box<Game>(
      maxSizeMiB: 1,
      name: 'GAMES',
    );
  }

  @override
  void clear() => _box.clear();

  @override
  void put(Game game) => _box.put(game.title, game);
}