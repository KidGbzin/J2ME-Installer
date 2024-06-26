import 'package:hive/hive.dart';

import '../entities/game_entity.dart';
import '../interfaces/favorites_interface.dart';

class Favorites implements IFavorites {
  late final Box<Game> _box;

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
  
  @override
  void close() => _box.close();
  
  @override
  void open() {
    _box = Hive.box<Game>(
      maxSizeMiB: 1,
      name: 'FAVORITES',
    );
  }

  @override
  void clear() => _box.clear();
}