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
  /// Return the audio as a [File] if exists or throws an error.
  Future<File> getAudio() async {
    final File file = await Android.read('$title.rtx');
    final bool exists = await file.exists(); 
    if (exists) return file;
    final Response response = await GitHub.get('$title.rtx');
    return await Android.write(response.bodyBytes, '$title.rtx');
  }

  /// Install the .JAR file into the J2ME Loader emulator.
  /// If the emulator is not installed then redirect to it's page on the PlayStore.
  Future<void> _install(File file) async {
    const MethodChannel channel = MethodChannel('br.com.kidgbzin.j2me_loader/install');
    await channel.invokeMethod('Install', file.path);
  }

  /// Open the .JAR file from cache/source then installs it.
  Future<void> openGame() async {
    isDownloading.value = true;
    try {
      final JAR jar = game.jars.firstWhere((element) => element.isComplete == true,
        orElse: () => throw "Sorry, there's no file to install yet. Please check another game.",
      );
      File file = await Android.read('$title/${jar.file}');
      final bool exists = await file.exists();
      if (!exists) {
        final Response response = await GitHub.get('$title/${jar.file}');
        file = await Android.write(response.bodyBytes, '$title/${jar.file}');
      }
      await _install(file);
    }    
    finally {
      isDownloading.value = false;
    }
  }

  /// Opens the emulator's page on the Google PlayStore.
  /// 
  /// Throws an exception if the PlayStore is not installed on the device.
  Future<void> openPlayStore() async {
    // Native Android call to install the .JAR file into J2ME Loader emulator.
    // The activity must be configured on the Android before used.
    const MethodChannel channel = MethodChannel('br.com.kidgbzin.j2me_loader/install');
    try {
      await channel.invokeMethod('PlayStore');
    }
    catch (error) {
      Logger.error.log('$error');
      throw 'The PlayStore is not installed on the device.';
    }
  }

  /// Opens the emulator's repository on the GitHub.
  /// 
  /// Throws an exception if something blocks the URL launcher.
  Future<void> openGitHub() async {
    final Uri url = Uri.parse("https://github.com/nikita36078/J2ME-Loader");
    try {
      await launchUrl(url);
    }
    catch (error) {
      Logger.error.log('$error');
      throw 'Could not open GitHub repository.';
    }
    
  }

  /// Discard the resourses used on the controller.
  void dispose() {
    isDownloading.dispose();
    progress.dispose();
  }
}