import '../entities/game_entity.dart';

abstract class IGames {
  int get length;

  Game? fromIndex(int index);

  Game? get(String title);

  void open();

  void close();

  void clear();

  void put(Game game);
}