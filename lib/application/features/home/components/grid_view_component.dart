part of '../home_handler.dart';

class _GridView extends StatelessWidget {

  const _GridView({
    required this.controller,
    required this.collection,
  });

  final _Controller controller;
  final Box<Game> collection;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 0.75,
        crossAxisSpacing: 12.5,
        crossAxisCount: 3,
        mainAxisSpacing: 12.5,
      ),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => context.push('/details/${collection[index]!.title}'),
          child: _Cover(Storage.getCover(collection[index]!.title)),
        );
      },
      itemCount: Database.games.length,
      padding: const EdgeInsets.all(15),
    );
  }
}