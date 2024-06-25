part of '../launcher/launcher_handler.dart';

class _Controller {

  _Controller({
    required this.database,
  });

  late final IDatabase database;


  final ValueNotifier<Progress> progress = ValueNotifier(Progress.loading);

  void dispose() {
    progress.dispose();
  }

  Future<void> initialize(BuildContext context) async {
    try {
      await database.initialize();
      
      if (!context.mounted) return;

      context.pushReplacement('/home');
    }
    catch (error) {
      Logger.error.log('$error');
      progress.value = Progress.error;
    }
  }
}