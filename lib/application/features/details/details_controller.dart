part of '../details/details_handler.dart';

/// The controller used to handle the [Details] state and data.
class _Controller {
  _Controller();

  /// The game used to show its data.
  late final Game game;

  /// The [isDownloading] listenable.
  /// 
  /// Used in the [_PlayButton] component, it represents whether any [MIDlet] files are being downloaded.
  late final ValueNotifier<bool> isDownloading;

  late final ValueNotifier<bool> isFavorite;

  /// The [progress] listenable.
  /// 
  /// Used in the [Details] handler, it represents the current state of the view when initialized.
  late final ValueNotifier<Progress> progress;
  
  /// Initialize the controller and fetch the necessary data.
  /// 
  /// While the controller is fetching, updates the state of it's [progress].
  Future<void> initialize(String title) async {
    isDownloading = ValueNotifier(false);
    progress = ValueNotifier(Progress.loading);
    try {
      game = Database.games.get(title)!;
      isFavorite = ValueNotifier(Database.isFavorite(game));
      progress.value = Progress.finished;
    }
    catch (_) {
      Logger.warning.log('Details • Controller | Couldn\'t find "$title" in the local database.');
      progress.value = Progress.error;
    }
  }

  /// Open the .JAR file from cache/source then installs it.
  Future<void> openGame() async {
    isDownloading.value = true;
    try {
      final MIDlet jar = game.midlets.firstWhere((element) => element.isComplete == true,
        orElse: () => throw "Sorry, there's no file to install yet. Please check another game.",
      );
      final File file = await Storage.getMIDlet(jar);
      await Activity.emulator(file);
    }
    finally {
      isDownloading.value = false;
    }
  }

  Future<void> openGitHub() async {
    try {
      await Activity.gitHub();
    }
    catch (error) {
      Logger.error.log('$error');
    }
  }

  Future<void> openPlayStore() async {
    try {
      await Activity.playStore();
    }
    catch (error) {
      Logger.error.log('$error');
    }
  }

  /// Discard the resourses used on the controller.
  void dispose() {
    isDownloading.dispose();
    progress.dispose();
  }

  void bookmark() {
    if (isFavorite.value) {
      Database.removeFavorite(game);
    }
    else {
      Database.putFavorite(game);
    }
    isFavorite.value = !isFavorite.value;
  }
}