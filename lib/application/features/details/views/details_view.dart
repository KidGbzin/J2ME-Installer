part of '../details_handler.dart';

class _Details extends StatefulWidget {
  const _Details(this.controller);

  final _Controller controller;

  @override
  State<_Details> createState() => __DetailsState();
}

class __DetailsState extends State<_Details> with WidgetsBindingObserver {
  late Game game;
  late AudioPlayer player;
  late ScaffoldMessengerState snackbar;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    game = widget.controller.game;
    player = AudioPlayer();
    playAudio();

    super.initState();
  }

  @override
  void didChangeDependencies() {
    snackbar = ScaffoldMessenger.of(context);

    super.didChangeDependencies();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // If the application returns to resume state, then resume de music player.
    if (state == AppLifecycleState.resumed) {
      player.resume();
    }

    // If the application is not in the main view, then stops the music player.
    else {
      player.pause();
    }

    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    snackbar.clearSnackBars();
    player.dispose();

    super.dispose();
  }

  /// Play the game's theme.
  /// 
  /// Try to load the audio, if for some reason it can't it just doesn't do anything.
  Future<void> playAudio() async {
    try {
      final File file = await widget.controller.getAudio();
      await player.play(DeviceFileSource(file.path));
    }
    catch (_) {}
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
          _Cover(
            getCover: widget.controller.getCover(),
          ),
          const _Divider(),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 15, 0, 10),
            child: Text(
            game.title.toUpperCase(),
              style: Typographies.header(Palette.elements).style,
              maxLines: 1,
              overflow: TextOverflow.clip,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: Text(
              "${game.release} • ${game.vendor}",
              style: Typographies.body(Palette.grey).style,
              textAlign: TextAlign.left,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
            child: Tags(game.tags),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
            child: Text(
              game.description ?? '',
              style: Typographies.body(Palette.grey).style,
            ),
          ),
          const _Divider(),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
            child: Row(
              children: <Widget> [
                _PlayButton(widget.controller),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                    child: GestureDetector(
                      onTap: () {
                        // TODO: Add a action here.
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget> [
                          Text(
                            "Other Versions",
                            style: Typographies.body(Palette.elements).style,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                            child: Icon(
                              Icons.code_rounded,
                              color: Palette.elements.color,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}