part of '../details_handler.dart';

class _About extends StatelessWidget {
  const _About(this.description);

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
            "ABOUT",
            style: Typographies.category(Palette.elements).style,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 25),
          child: Text(
            description,
            style: Typographies.body(Palette.grey).style,
          ),
        ),
      ],
    );
  }
}