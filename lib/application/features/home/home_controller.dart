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
}