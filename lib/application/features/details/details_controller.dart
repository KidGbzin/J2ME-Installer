part of '../details/details_handler.dart';

/// The controller used to handle the [Details] state and data.
class _Controller {
  _Controller();

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
  Future<void> initialize(String title) async {
    isDownloading = ValueNotifier(false);
    progress = ValueNotifier(Progress.loading);
    try {
      await Storage.getIcon(title);
      game = Database.games.get(title)!;
      progress.value = Progress.finished;
    }
    catch (_) {
      Logger.warning.log('Details • Controller | Couldn\'t find "$title" in the local database.');
      progress.value = Progress.error;
    }
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
      final File file = await Storage.getPackage(jar);
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