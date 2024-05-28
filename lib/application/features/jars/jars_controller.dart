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

  /// Tries to get the game's icon from the device system by it's [title].
  /// 
  /// Return the cover audio as a [File] if exists.
  Future<File> getIcon(String title) async {
    File file = await Android.read(
      folder: Folder.icons.directory(),
      name: '$title.png',
    );
    final bool exists = await file.exists();
    if (exists) return file;
    try {
      final String source = Folder.icons.file(
        file: '$title.png',
      );
      final Response response = await GitHub.fetch(source);
      file = await Android.write(
        bytes: response.bodyBytes,
        folder: Folder.icons.directory(),
        name: '$title.png',
      );
      return file;
    }
    catch (_) {
      return file;
    }
  }
}