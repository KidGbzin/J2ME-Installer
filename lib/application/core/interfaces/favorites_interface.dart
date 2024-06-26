import '../entities/game_entity.dart';

abstract class IFavorites { 

  int get length;

  Game? fromIndex(int index);

  bool contains(Game game);

  void put(Game game);

  void delete(Game game);

  void open();

  void close();

  void clear();
}