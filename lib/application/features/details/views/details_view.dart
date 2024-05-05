part of '../details_handler.dart';

class _Details extends StatelessWidget {
  final Game game;

  const _Details(this.game);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget> [
            Button(
              icon: Icons.arrow_back,
              onTap: context.pop,
            ),
          ],
        ),
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: <Widget> [
          const _Cover(),
          const _Divider(),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 15, 0, 10),
            child: Text(
            game.title.toUpperCase(),
              style: Typographies.header(Palette.elements).style,
              maxLines: 1,
              overflow: TextOverflow.clip,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: Text(
              "${game.release} • ${game.vendor}",
              style: Typographies.body(Palette.grey).style,
              textAlign: TextAlign.left,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
            child: Tags(game.tags),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
            child: Text(
              game.description ?? '',
              style: Typographies.body(Palette.grey).style,
            ),
          ),
          const _Divider(),
          const Padding(
            padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
            child: Align(
              alignment: Alignment.centerLeft,
              child: _PlayButton(),
            ),
          ),
        ],
      ),
    );
  }
}