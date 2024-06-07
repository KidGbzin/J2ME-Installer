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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          children: <Widget> [
            Button(
              icon: Icons.search_rounded,
              onTap: () {},
            ),
          ],
        ),
      ),
      body: _Lister(
        controller: widget.controller,
      ),
    );
  }
}