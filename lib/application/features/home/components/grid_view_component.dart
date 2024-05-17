part of '../home_handler.dart';

class _GridView extends StatelessWidget {
  final _Controller controller;

  const _GridView(this.controller);

  @override
  Widget build(BuildContext context) {
    final List<Game> collection = Repository.collection;
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
          onTap: () => context.push('/details/${collection[index].title}'),
          child: _Cover(controller.getCover(collection[index].title)),
        );
      },
      itemCount: collection.length,
      padding: const EdgeInsets.all(15),
    );
  }
}