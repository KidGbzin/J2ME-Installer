part of '../launcher/launcher_handler.dart';

class _Controller {

  _Controller({
    required this.database,
  });

  late final IDatabase database;

  late final String message;

  final PageController pageController = PageController(
    initialPage: 0,
  );

  final ValueNotifier<int> pageIndex = ValueNotifier(0);

  final ValueNotifier<Progress> progress = ValueNotifier(Progress.loading);

  void dispose() {
    progress.dispose();
  }

  Future<void> initialize(BuildContext context) async {
    try {
      await database.initialize();
  
      progress.value = Progress.finished;
    }
    on ClientException catch (error) {
      Logger.error.print(
        label: 'Launcher | Controller',
        message: '$error',
      );
      message = 'The server could not be reached.\nPlease check your internet connection or try again later.';
      progress.value = Progress.error;
    }
    on ResponseException catch (error) {
      if (error.statusCode == HttpStatus.notFound) {
        message = 'Sorry, the server is offline!\nPlease try again later.';
      }
      else {
        message = 'The server returned ${error.statusCode}.\nPlease try again later.';
      }
      progress.value = Progress.error;
    }
    catch (error) {
      Logger.error.print(
        label: 'Launcher | Controller',
        message: '$error',
      );
      message = 'Internal error!';
      progress.value = Progress.error;
    }
  }

  void goTo() {
    pageController.animateToPage(
      1,
      duration: const Duration(
        milliseconds: 400,
      ),
      curve: Curves.decelerate,
    );
  }
}