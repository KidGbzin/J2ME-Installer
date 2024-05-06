part of '../details_handler.dart';

/// Install the recommended .JAR file into the emulator, if any.
class _PlayButton extends StatelessWidget {
  const _PlayButton();

  @override
  Widget build(BuildContext context) {
    final double width = (MediaQuery.sizeOf(context).width - 45) / 2;
    return GestureDetector(
      onTap: () {
        _install(context);
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Palette.primary.color.withOpacity(0.33),
          ),
          borderRadius: BorderRadius.circular(15),
          color: Palette.primary.color.withOpacity(0.33),
        ),
        height: 40,
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
        width: width,
        child: _listener(_Notifier.of(context)!.isDownloading),
      ),
    );
  }

  /// The button state listener.
  Widget _listener(ValueNotifier<bool> isDownloading) {
    return ValueListenableBuilder(
      builder: (BuildContext context, bool value, Widget? _) {
        if (value == true) return _isDownloading();
        return _playGame();
      },
      valueListenable: isDownloading,
    );
  }

  /// Tries to install the game on the J2ME emulator.
  Future<void> _install(BuildContext context) async {
    final _Controller controller = _Notifier.of(context)!;
    try {
      // If the game is not already downloading, tries to install the game or return an error.
      if (controller.isDownloading.value == false) await controller.install();
    }
    catch (error) {
      // If an error is returned, show a message to the user.
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: SizedBox(
          height: 41,
          width: double.infinity,
          child: Text(
            '$error',
            style: Typographies.body(Palette.elements).style,
          ),
        ),
        padding: const EdgeInsets.all(15),
      ));
    }
  }

  /// The button body when the game is downloading.
  Widget _isDownloading() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget> [
        Icon(
          Icons.downloading_rounded,
          color: Palette.elements.color,
        ),
      ],
    );
  }

  /// The button body to download and install.
  Widget _playGame() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget> [
        Expanded(
          child: Text(
            "Play Game",
            style: Typographies.tile(Palette.elements).style,
            textAlign: TextAlign.center,
          ),
        ),
        Icon(
          Icons.play_arrow_rounded,
          color: Palette.elements.color,
        ),
      ],
    );
  }
}