part of '../home/home_handler.dart';

class _Controller {
  _Controller._();

  factory _Controller() {
    _initialize();
    return _Controller._();
  }

  static late ValueNotifier<ViewType> view;
  static late ValueNotifier<Progress> progress;

  /// Getters:
  ValueNotifier<ViewType> get viewState => view;
  ValueNotifier<Progress> get progressState => progress;

  /// Toggle the view state, change the state between list or grid.
  void toggleView() => view.value = (view.value == ViewType.listView) ? ViewType.gridView : ViewType.listView;

  /// Initialize the controller and fetch the necessary data.
  /// 
  /// While the controlles is fetching updates the progress of it's [progress].
  static Future<void> _initialize() async {
    view = ValueNotifier(ViewType.listView);
    progress = ValueNotifier(Progress.loading);
    try {
      await Android.initialize();
      await Database.initialize();
      progress.value = Progress.finished;
    }
    catch (error) {
      Logger.error.log('Home • Controller | $error');
      progress.value = Progress.error;
    }
  }

  /// Get the cover image from device system as [File] using the game [title].
  /// 
  /// If the cache does not exist, then thies to fetch from GitHub API.
  Future<File> getCover(String title) async {
    File file = Android.read(
      folder: Folder.covers.directory(),
      name: '$title.png',
    );
    final bool exists = await file.exists();
    if (exists) return file;
    try {
      final String source = Folder.covers.file(
        file: "$title.png",
      );
      final Response response = await GitHub.fetch(source);
      file = await Android.write(
        bytes: response.bodyBytes,
        folder: Folder.covers.directory(),
        name: '$title.png',
      );
      return file;
    }
    catch (_) {
      return file;
    }
  }
}