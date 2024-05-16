part of '../home/home_handler.dart';

/// The [InheritedNotifier] for [Home] view.
class _Notifier extends InheritedNotifier<_Controller> {
  const _Notifier({
    required _Controller super.notifier,
    required super.child,
  });

  static _Controller? of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<_Notifier>()!.notifier;
}

/// The [Home] controller, used to manipulate states and operations.
class _Controller extends ChangeNotifier implements IController {
  late final List<Game> games;
  late States state;
  late ValueNotifier<bool> isListView;

  /// The [_Controller] constructor. After create a instance make sure to [initialize] it.
  _Controller();

  @override
  Future<void> initialize() async {
    isListView = ValueNotifier(true);
    state = States.loading;
    try {
      await Android.initialize();
      await Repository.fetch();
      games = Repository.collection;
      state = States.finished;
    }
    catch (error) {
      state = States.error;
    }
  }

  void changeView() {
    if (isListView.value) {
      isListView.value = false;
    }
    else {
      isListView.value = true;
    }
  }

  /// Get the thumbnail from cache system as [Uint8List]. \
  /// If the cache does not exist, then thies to [_fetchThumbnail] from source.
  /// 
  /// The parameter [title] is self-explanatory, just the game's title. It is of type [String].
  Future<File> loadThumbnail(String title) async {
    final File file = await Android.load('splash.png', title.replaceAll(':', ' -'));
    final bool exists = await file.exists(); 

    // If exists play the .RTX theme.
    if (exists) {
      return file;
    }

    // If the file is not found in cache, then tries to fetch from source.
    else {
      return _fetchThumbnail(title);
    }
  }

  /// Fetch the .PNG file from source then stores in the cache system.
  /// When the file is successfully cached also [notifyListeners].
  /// 
  /// The parameter [title] is self-explanatory, just the game's title. It is of type [String].
  Future<File> _fetchThumbnail(String title) async {
    final String name = title.replaceAll(':', ' -');
    late final File file;
    try {
      final Response response = await GitHub.getPNG('$name.png');
      file = await Android.write(response.bodyBytes, 'splash.png', name);
      return file;
    }
    catch (_) {
      return file;
    }
  }
}