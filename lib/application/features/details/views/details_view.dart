part of '../details_handler.dart';

class _Details extends StatefulWidget {
  final Game game;

  const _Details(this.game);

  @override
  State<_Details> createState() => __DetailsState();
}

class __DetailsState extends State<_Details> with WidgetsBindingObserver {

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // If the application is not in the main view, then stops the music player.
    if (state != AppLifecycleState.resumed) {
      _Notifier.of(context)!.player.stop();
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget> [
            Button(
              icon: Icons.arrow_back,
              onTap: context.pop,
            ),
          ],
        ),
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: <Widget> [
          const _Cover(),
          const _Divider(),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 15, 0, 10),
            child: Text(
            widget.game.title.toUpperCase(),
              style: Typographies.header(Palette.elements).style,
              maxLines: 1,
              overflow: TextOverflow.clip,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: Text(
              "${widget.game.release} • ${widget.game.vendor}",
              style: Typographies.body(Palette.grey).style,
              textAlign: TextAlign.left,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
            child: Tags(widget.game.tags),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
            child: Text(
              widget.game.description ?? '',
              style: Typographies.body(Palette.grey).style,
            ),
          ),
          const _Divider(),
          const Padding(
            padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
            child: Align(
              alignment: Alignment.centerLeft,
              child: _PlayButton(),
            ),
          ),
        ],
      ),
    );
  }
}