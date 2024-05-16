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
          SizedBox(
            height: 120,
            width: 120 * 0.75,
            child: _Cover(game.title),
          ),
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
}