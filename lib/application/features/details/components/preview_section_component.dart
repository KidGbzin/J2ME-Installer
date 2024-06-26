part of '../details_handler.dart';

class _Preview extends StatefulWidget {

  const _Preview({
    required this.previews,
  });

  final List<Uint8List> previews;

  @override
  State<_Preview> createState() => _PreviewState();
}

class _PreviewState extends State<_Preview> {
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
          child: _previews(),
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

  Widget _previews() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: <Widget> [
          Expanded(
            child: _image(widget.previews[0]),
          ),
          _divider(),
          Expanded(
            child: _image(widget.previews[1]),
          ),
          _divider(),
          Expanded(
            child: _image(widget.previews[2]),
          ),
        ],
      ),
    );
  }

  Widget _image(Uint8List bytes) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Align(
              alignment: Alignment.center,
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: kElevationToShadow[3],
                ),
                margin: const EdgeInsets.all(30),
                child: _Screenshot(bytes),
              ),
            );
          },
        );
      },
      child: _Screenshot(bytes),
    );
  }
}