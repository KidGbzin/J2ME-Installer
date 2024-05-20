part of '../home_handler.dart';

class _ListView extends StatelessWidget {

  const _ListView({
    required this.controller,
    required this.collection,
  });

  final _Controller controller;
  final Box<Game> collection;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => context.push('/details/${collection[index]!.title}'),
          child: _Tile(collection[index]!, controller),
        );
      },
      itemCount: Database.games.length,
      separatorBuilder: (BuildContext context, int index) {
        return Divider(
          color: Palette.transparent.color,
          height: 1,
          thickness: 1,
        );
      },
    );
  }
}