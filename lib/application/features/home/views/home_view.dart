part of '../home_handler.dart';

class _View extends StatefulWidget {
  const _View(this.controller);

  final _Controller controller;

  @override
  State<_View> createState() => _ViewState();
}

class _ViewState extends State<_View> {

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
        title: const Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget> [
          ],
        ),
      ),
      body: _Lister(
        collection: Database.games,
        controller: widget.controller,
      ),
    );
  }
}