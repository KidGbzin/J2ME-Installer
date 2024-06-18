part of '../details_handler.dart';

class _Collection extends StatelessWidget {
  const _Collection({
    required this.description,
    required this.games,
    required this.title,
  });

  final List<Game> games;

  final String title;

  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget> [
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 25, 15, 15),
          child: Text(
            title,
            style: Typographies.category(Palette.elements).style,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
          child: Text(
            description,
            style: Typographies.body(Palette.grey).style,
          ),
        ),
      ],
    );
  }
}