part of '../details_handler.dart';

class _PlayButton extends StatelessWidget {
  const _PlayButton();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _Notifier.of(context)!.install(context);
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
        child: Row(
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
        ),
      ),
    );
  }
}