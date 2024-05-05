part of '../details_handler.dart';

class _PlayButton extends StatelessWidget {
  const _PlayButton();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _tryInstall(context);
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
        width: (MediaQuery.sizeOf(context).width - 45) / 2,
        child: ValueListenableBuilder(
          builder: (BuildContext context, bool isDownloading, Widget? _) {
            return _buttonBody(isDownloading);
          },
          valueListenable: _Notifier.of(context)!.isDownloading,
        ),
      ),
    );
  }

  Future<void> _tryInstall(BuildContext context) async {
    final _Controller controller = _Notifier.of(context)!;
    try {
      if (controller.isDownloading.value == false) await controller.install();
    }
    catch (error) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(Warning('$error'));
    }
  }

  Widget _buttonBody(bool isDownloading) {
    if (isDownloading) {
      return Icon(
        Icons.download,
        color: Palette.elements.color,
      );
    }
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
          Icons.play_arrow,
          color: Palette.elements.color,
        ),
      ],
    );
  }
}