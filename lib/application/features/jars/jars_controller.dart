part of '../jars/jars_handler.dart';

class _Controller {
  _Controller();

  late final List<JAR> jars;

  /// The [progress] listenavle.
  /// 
  /// Used in the [JARs] handler, it represents the current state of the view when initialized.
  late final ValueNotifier<Progress> progress;

  /// Initialize the controller and fetch the necessary data using a game [title].
  /// 
  /// While the controller is fetching, updates the state of it's [progress].
  void initialize(String title) {
    progress = ValueNotifier(Progress.loading);
    try {
      jars = Database.games.get(title)!.jars;
      progress.value = Progress.finished;
    }
    catch (_) {
      Logger.warning.log('JARs • Controller | Couldn\'t find "$title" in the local database.');
      progress.value = Progress.error;
    }
  }
}