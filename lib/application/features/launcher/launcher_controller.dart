part of '../launcher/launcher_handler.dart';

class _Controller {

  _Controller({
    required this.database,
  });

  late final IDatabase database;

  late final String message;

  final ValueNotifier<Progress> progress = ValueNotifier(Progress.loading);

  void dispose() {
    progress.dispose();
  }

  Future<void> initialize(BuildContext context) async {
    try {
      await database.initialize();
  
      if (context.mounted) {
        context.pushReplacement('/home');
      }
    }
    on ClientException catch (error) {
      Logger.error.log('$error');
      message = 'The server could not be reached.\nPlease check your internet connection or try again later.';
      progress.value = Progress.error;
    }
    on ResponseException catch (error) {
      if (error.statusCode == HttpStatus.notFound) {
        message = 'Sorry, we were unable to fetch the database.\nPlease try again later.';
      }
      else {
        message = 'The server returned ${error.statusCode}.\nPlease try again later.';
      }
      progress.value = Progress.error;
    }
    catch (error) {
      Logger.error.log('$error');
      message = 'Internal error!';
      progress.value = Progress.error;
    }
  }
}