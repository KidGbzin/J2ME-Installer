part of '../home_handler.dart';

class _Lister extends StatelessWidget {
  const _Lister({
    required this.controller,
  });

  final _Controller controller;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (BuildContext context, int index) {
        final Game game = controller.getGame(index);
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => context.push('/details/${game.title}'),
          child: _Tile(
            controller: controller,
            game: game,
          ),
        );
      },
      itemCount: controller.getGamesLength(),
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