part of '../details_handler.dart';

class _Previews extends StatefulWidget {

  const _Previews({
    required this.controller,
  });

  final _Controller controller;

  @override
  State<_Previews> createState() => _PreviewsState();
}

class _PreviewsState extends State<_Previews> {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget> [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
          child: Text(
            "PREVIEWS",
            style: Typographies.category(Palette.elements).style,
          ),
        ),
        Text(
          "The game's characteristics and screenshots may vary according to the model of your phone.",
          style: Typographies.body(Palette.grey).style,
        ),
        SizedBox(
          height: _height(context),
          width: double.infinity,
          child: FutureBuilder(
            builder: (BuildContext context, AsyncSnapshot<List<Uint8List>> snapshot) {
              if (snapshot.hasData) {
                final List<Uint8List> previews = snapshot.data!;
                return _previews(previews);
              }
              else if (snapshot.hasError) {
                if (snapshot.error is ResponseException) {
                  final ResponseException exception = snapshot.error as ResponseException;
                  Logger.error.print(
                    label: 'Details | Previews',
                    message: exception.message,
                  );
                }
                return Icon(
                  Icons.broken_image_rounded,
                  color: Palette.grey.color,
                );
              }
              else {
                return Icon(
                  Icons.downloading_rounded,
                  color: Palette.elements.color,
                );
              }
            },
            future: widget.controller.getPreviews(),
          ),
        ),
      ],
    );
  }

  /// Calculates the height for the previews section.
  ///
  /// This formula ensures that each preview maintains the correct aspect ratio.
  double _height(BuildContext context) {
    return (MediaQuery.of(context).size.width - 30) / 3 / 0.75;
  }

  /// A bullet divider for the previews.
  Widget _bullet() {
    return SizedBox.square(
      dimension: 15,
      child: Icon(
        Icons.circle,
        color: Palette.foreground.color,
        size: 2.5,
      ),
    );
  }


  Widget _previews(List<Uint8List> previews) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: <Widget> [
          Expanded(
            child: _image(previews[0]),
          ),
          _bullet(),
          Expanded(
            child: _image(previews[1]),
          ),
          _bullet(),
          Expanded(
            child: _image(previews[2]),
          ),
        ],
      ),
    );
  }

  Widget _image(Uint8List bytes) {
    return AspectRatio(
      aspectRatio: 0.75,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Palette.divider.color,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: MemoryImage(bytes),
            filterQuality: FilterQuality.none,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}