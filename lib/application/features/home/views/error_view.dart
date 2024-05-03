part of '../home_handler.dart';

class _Error extends StatelessWidget {
  const _Error();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: <Widget> [
          Align(
            alignment: Alignment.center,
            child: SizedBox.square(
              dimension: 175,
              child: Image.asset(
                'assets/java.png',
                color: Palette.elements.color,
                filterQuality: FilterQuality.high,
              ),
            ),
          ),
          SizedBox(
            height: 50,
            child: Text(
              'Unable to fetch the API.',
              style: Typographies.body(Palette.elements).style,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}