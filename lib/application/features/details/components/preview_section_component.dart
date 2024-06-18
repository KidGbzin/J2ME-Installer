part of '../details_handler.dart';

class _Preview extends StatelessWidget {
  const _Preview();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget> [
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 25, 15, 15),
          child: Text(
            "SCREENSHOTS",
            style: Typographies.category(Palette.elements).style,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
          child: Text(
            "The game's characteristics and screenshots may vary according to the model of your phone.",
            style: Typographies.body(Palette.grey).style,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: _screenshots(),
        ),
      ],
    );
    
  }

  Widget _divider() {
    return SizedBox.square(
      dimension: 15,
      child: Icon(
        Icons.circle,
        color: Palette.foreground.color,
        size: 2.5,
      ),
    );
  }

  Widget _screenshots() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        children: <Widget> [
          Expanded(
            child: _image(),
          ),
          _divider(),
          Expanded(
            child: _image(),
          ),
          _divider(),
          Expanded(
            child: _image(),
          ),
        ],
      ),
    );
  }

  Widget _image() {
    return AspectRatio(
      aspectRatio: 0.75,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          border: Border.all(
            color: Palette.divider.color,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
          color: Palette.foreground.color,
          // TODO: Create the game screenshots.
        ),
      ),
    );
  }
}