part of '../home_handler.dart';

/// Build a [ListView] from a collection.
/// 
/// The [collection] parameter is a list of games. It's a [List] of type [Game].
class _ListView extends StatelessWidget {
  final List<Game> collection;

  const _ListView(this.collection);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => context.push('/details/${collection[index].title}'),
          child: _Tile(collection[index]),
        );
      },
      itemCount: collection.length,
      padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
      physics: const BouncingScrollPhysics(),
      separatorBuilder: (BuildContext context, int index) {
        return Divider(
          color: Palette.divider.color,
          height: 1,
          thickness: 1,
        );
      },
    );
  }
}