part of '../details_handler.dart';

class _Screenshots extends StatelessWidget {
  const _Screenshots();

  @override
  Widget build(BuildContext context) {
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