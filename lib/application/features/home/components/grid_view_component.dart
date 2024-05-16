part of '../home_handler.dart';

class _GridView extends StatelessWidget {
  final List<Game> collection;

  const _GridView(this.collection);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 0.75,
        crossAxisSpacing: 10,
        crossAxisCount: 4,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => context.push('/details/${collection[index].title}'),
          child: _Cover(collection[index].title),
        );
      },
      itemCount: collection.length,
      padding: const EdgeInsets.all(15),
    );
  }
}