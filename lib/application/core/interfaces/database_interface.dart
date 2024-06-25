import '../interfaces/favorites_interface.dart';
import '../interfaces/games_interface.dart';

abstract class IDatabase {
  Future<void> initialize();

  IGames get games;

  IFavorites get favorites;
}