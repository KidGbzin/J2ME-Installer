part of '../home/home_handler.dart';

class _Controller {
  _Controller._();

  factory _Controller() {
    _initialize();
    return _Controller._();
  }

  static late ValueNotifier<Progress> progress;

  ValueNotifier<Progress> get progressState => progress;


  /// Initialize the controller and fetch the necessary data.
  /// 
  /// While the controlles is fetching updates the progress of it's [progress].
  static Future<void> _initialize() async {
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