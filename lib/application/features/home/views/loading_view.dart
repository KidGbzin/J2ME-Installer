part of '../home_handler.dart';

class _Loading extends StatelessWidget {
  const _Loading();

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
            child: Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                color: Palette.elements.color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}