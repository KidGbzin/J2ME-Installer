part of '../home/home_handler.dart';

class _Controller {

  _Controller({
    required this.bucket,
    required this.database,
  });

  late final IBucket bucket;
  late final IDatabase database;

  /// The [progress] listenavle.
  /// 
  /// Used in the [Home] handler, to know the current state of the view when initialized.
  late final ValueNotifier<Progress> progress = ValueNotifier(Progress.loading);

  /// Initialize the controller and fetch the necessary data.
  /// 
  /// While the controlles is fetching updates the progress of it's [progress].
  Future<void> initialize() async {
    try {
      progress.value = Progress.finished;
    }
    catch (error) {
      Logger.error.log('Home • Controller | $error');
      progress.value = Progress.error;
    }
  }

  void dispose() {
    progress.dispose();
  }

  Future<File> getGameCover(String title) {
    return bucket.thumbnail(title);
  }

  Game getGame(int index) {
    return database.games.fromIndex(index)!;
  }

  int getGamesLength() {
    return database.games.length;
  }
}