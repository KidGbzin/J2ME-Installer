part of '../home_handler.dart';

class _Tile extends StatelessWidget {
  final Game game;
  final _Controller controller;

  const _Tile(this.game, this.controller);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      width: double.infinity,
      child: Row(
        children: <Widget> [
          SizedBox(
            height: 120,
            width: 120 * 0.75,
            child: _Cover(Storage.getCover(game.title)),
          ),
          Expanded(
            child: SizedBox(
              height: 120,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 7.5),
                    child: Text(
                      "${game.description}",
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
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
          ),
        ],
      ),
    );
  }
}