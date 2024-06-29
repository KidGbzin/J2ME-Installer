part of '../launcher_handler.dart';

class _Install extends StatelessWidget {

  const _Install(this.controller);

  final _Controller controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget> [
        Positioned(
          bottom: 50,
          right: 15,
          child: _nextButton(context),
        ),
      ],
    );
  }

  Widget _nextButton(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        context.pushReplacement('/home');
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget> [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 3, 7.5, 0),
            child: Text(
              'FINISH',
              style: Typographies.category(Palette.elements).style,
            ),
          ),
          SizedBox.square(
            dimension: 37.5,
            child: Icon(
              Icons.arrow_forward_rounded,
              color: Palette.elements.color,
            ),
          )
        ],
      ),
    );
  }
}