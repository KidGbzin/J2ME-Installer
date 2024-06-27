import 'package:hive/hive.dart';
import 'package:j2me_installer/application/core/exceptions/database_exceptions.dart';

import '../entities/game_entity.dart';

import '../interfaces/games_interface.dart';

class Games implements IGames {
  late final Box<Game> _box;

  @override
  Game fromIndex(int index) {
    final Game? game = _box[index];
    if (game == null) {
      throw GameException(
        message: 'The index "$index" is out of range ${_box.length}!',
      );
    }
    return game;
  }

  @override
  int get length => _box.length;

  @override
  Game get(String title) {
    final Game? game = _box.get(title);
    if (game == null) {
      throw GameException(
        message: 'The game "$title" does not exist on the box!',
      );
    }
    return game;
  }
  
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