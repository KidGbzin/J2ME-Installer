part of '../home_handler.dart';

class _Tile extends StatelessWidget {
  final Game game;

  const _Tile(this.game);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 155,
      padding: const EdgeInsets.all(15),
      width: double.infinity,
      child: Row(
        children: <Widget> [
          _cover(context),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget> [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                  child: Text(
                    game.title,
                    style: Typographies.tile(Palette.elements).style,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 5, 15, 7.5),
                  child: Text(
                    "${game.release} • ${game.vendor}",
                    style: Typographies.body(Palette.grey).style,
                    textAlign: TextAlign.start,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                  child: Tags(game.tags),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _cover(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Palette.divider.color,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(7.5),
        color: Palette.foreground.color,
        image: DecorationImage(
          fit: BoxFit.contain,
          filterQuality: FilterQuality.none,
          image: _Notifier.of(context)!.loadThumbnail(game.title),
        ),
      ),
      height: 120,
      width: 120 * 0.75,
    );
  }
}