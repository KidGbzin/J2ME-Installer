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
        title: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget> [
            const Spacer(),
            _ToggleButton(
              listenable: widget.controller.viewState,
              onTap: widget.controller.toggleView,
            ),
          ],
        ),
      ),
      body: _view(),
    );
  }

  Widget _view() {
    return ValueListenableBuilder(
      builder: (BuildContext context, ViewType view, Widget? _) {
        if (view == ViewType.listView) {
          return _ListView(widget.controller);
        }
        else {
          return _GridView(widget.controller);
        }
      },
      valueListenable: widget.controller.viewState,
    );
  }
}