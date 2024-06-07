part of '../launcher/launcher_handler.dart';

class _Controller {
  _Controller();

  final ValueNotifier<Progress> progress = ValueNotifier(Progress.loading);

  void dispose() {
    progress.dispose();
  }

  Future<void> initialize(BuildContext context) async {
    try {
      await Android.initialize();
      await Database.initialize();
      if (!context.mounted) return;
      context.pushReplacement('/home');
    }
    catch (_) {
      progress.value = Progress.error;
    }
  }
}