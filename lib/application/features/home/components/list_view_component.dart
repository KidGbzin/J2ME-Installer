part of '../home_handler.dart';

class _ListView extends StatelessWidget {
  final _Controller controller;

  const _ListView(this.controller);

  @override
  Widget build(BuildContext context) {
    final List<Game> collection = Repository.collection;
    return ListView.separated(
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => context.push('/details/${collection[index].title}'),
          child: _Tile(collection[index], controller),
        );
      },
      itemCount: collection.length,
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