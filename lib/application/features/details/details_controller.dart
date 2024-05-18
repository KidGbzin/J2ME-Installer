part of '../details/details_handler.dart';

/// The controller used to handle the [Details] state and data.
class _Controller {

  _Controller(this.title);

  /// Self-explanatory, just the game's title.
  /// 
  /// It is used as an identifier in the repository.
  final String title;

  /// The game used to show its data.
  late final Game game;

  /// The [isDownloading] listenable.
  /// 
  /// Used in the [_PlayButton] component, it represents whether any [JAR] files are being downloaded.
  late final ValueNotifier<bool> isDownloading;

  /// The [progress] listenavle.
  /// 
  /// Used in the [Details] handler, it represents the current state of the view when initialized.
  late final ValueNotifier<Progress> progress;
  
  /// Initialize the controller and fetch the necessary data.
  /// 
  /// While the controller is fetching, updates the state of it's [progress].
  Future<void> initialize() async {
    isDownloading = ValueNotifier(false);
    progress = ValueNotifier(Progress.loading);
    try {
      game = Repository.collection.firstWhere((element) => element.title == title);
      progress.value = Progress.finished;
    }
    catch (_) {
      Logger.error.log('Unable to find the game $title on the repository!');
      progress.value = Progress.error;
    }
  }

  /// Tries to get the game's cover from the device system by it's [title].
  /// 
  /// Return the cover audio as a [File] if exists.
  Future<File> getCover() async {
    final File file = await Android.read('$title.png');
    final bool exists = await file.exists();
    if (exists) return file;
    throw 'The game "$title" there\'s no cover cached.';
  }

  /// Tries to get the game's cover from the device system by it's [title].
  /// 
  /// Return the audio as a [File] if exists.
  Future<File> getAudio() async {
    final File file = await Android.read('$title.rtx');
    final bool exists = await file.exists(); 
    if (exists) return file;
    try {
      final Response response = await GitHub.get('$title.rtx');
      final File file = await Android.write(response.bodyBytes, '$title.rtx');
      return file;
    }
    catch (error) {
      rethrow;
    }
  }

  /// Install the .JAR file into the J2ME Loader emulator. If the emulator is not installed then redirect to it's page on the PlayStore.
  Future<void> install() async {
    isDownloading.value = true;
    try {
      final JAR jar = game.jars.firstWhere((element) => element.isComplete == true,
        orElse: () => throw "Sorry, there's no file to install yet. Please check another game.",
      );
      final Response response = await GitHub.get('$title/${jar.file}');
      
      final File file = await Android.temporary(response.bodyBytes);

      // Native Android call to install the .JAR file into J2ME Loader emulator.
      // The activity must be configured on the Android before used.
      const MethodChannel channel = MethodChannel('br.com.kidgbzin.j2me_loader/install');
      await channel.invokeMethod('openJarFile', file.path);
    }
    finally {
      isDownloading.value = false;
    }
  }

  /// Discard the resourses used on the controller.
  void dispose() {
    isDownloading.dispose();
    progress.dispose();
  }
}