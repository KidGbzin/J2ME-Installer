part of '../details_handler.dart';

class _Install extends StatelessWidget {

  const _Install({
    required this.controller,
  });

  final _Controller controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget> [
        Text(
          "INSTALL",
          style: Typographies.category(Palette.elements).style,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 15, 0, 25),
          child: Text.rich(
            TextSpan(
              children: <InlineSpan> [
                TextSpan(
                  text: "Not sure which version to choose?\n",
                  style: Typographies.body(Palette.grey).style,
                ),
                TextSpan(
                  text: "Simply press play, and we'll install the best version for you.",
                  style: Typographies.body(Palette.grey).style,
                ),
              ]
            )
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: <Widget> [
            Expanded(
              child: _midletsButton(),
            ),
            VerticalDivider(
              color: Palette.transparent.color,
              width: 25,
            ),
            Expanded(
              child: _playButton(),
            ),
          ],
        ),
      ],
    );
  }

  Widget _playButton() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Palette.primary.color.withOpacity(0.33),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(100),
        color: Palette.primary.color.withOpacity(0.10),
      ),
      padding: const EdgeInsets.fromLTRB(7.5, 0, 15, 0),
      height: 45,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget> [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 1, 0, 0),
              child: Text(
                'Play Game',
                style: Typographies.button(Palette.primary2).style,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Icon(
            Icons.download_rounded,
            color: Palette.primary2.color,
            size: 25,
          ),
        ],
      ),
    );
  }

  Widget _midletsButton() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Palette.divider.color,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(100),
      ),
      padding: const EdgeInsets.fromLTRB(7.5, 0, 15, 0),
      height: 45,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget> [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 1, 0, 0),
              child: Text(
                'MIDlets',
                style: Typographies.button(Palette.grey).style,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Icon(
            Icons.code_rounded,
            color: Palette.grey.color,
            size: 25,
          ),
        ],
      ),
    );
  }
}