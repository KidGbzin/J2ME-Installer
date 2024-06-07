part of '../home_handler.dart';

class _Tile extends StatelessWidget {
  const _Tile({
    required this.controller,
    required this.game,
  });

  final _Controller controller;
  final Game game;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 165,
      padding: const EdgeInsets.all(15),
      width: MediaQuery.sizeOf(context).width,
      child: Row(
        children: <Widget> [
          _leading(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
              child: _body(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _leading() {
    return SizedBox(
      height: 115 + 20,
      width: 115 * 0.75,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: <Widget> [
          _Cover(getCover: controller.getGameCover(game.title)),
          const _Grade(),
          
        ],
      ),
    );
  }

  Widget _body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget> [
        Text(
          game.title.toUpperCase(),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Typographies.tile(Palette.elements).style,
          textAlign: TextAlign.start,
        ),
        Text(
          game.description ?? "",
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
          style: Typographies.body(Palette.grey).style,
        ),
        Tags(game.tags),
      ],
    );
  }
}