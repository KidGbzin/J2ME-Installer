part of '../home_handler.dart';

class _Home extends StatefulWidget {
  const _Home(this.controller);

  final _Controller controller;

  @override
  State<_Home> createState() => __HomeState();
}

class __HomeState extends State<_Home> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget> [
            Text(
              "MIDlet Store",
              style: Typographies.category(Palette.elements).style,
            ),
          ],
        ),
      ),
      body: _Lister(controller: widget.controller),
    );
  }
}