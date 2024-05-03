part of '../home_handler.dart';

class _Home extends StatelessWidget {
  const _Home();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            ImageIcon(
              const AssetImage('assets/java.png'),
              color: Palette.elements.color,
            )
          ],
        ),
      ),
      body: _ListView(_Notifier.of(context)!.games),
    );
  }
}