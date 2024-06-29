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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: <Widget> [
            Button(
              icon: Icons.arrow_back_rounded,
              onTap: context.pop,
            ),
            _Bookmark(
              controller: widget.controller,
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
          _divider(),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 25, 15, 25),
            child: _About(game.description ?? ''),
          ),
          _divider(),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 25, 15, 25),
            child: _Previews(
              controller: widget.controller,
            ),
          ),
          _divider(),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 25, 15, 25),
            child: _Install(
              controller: widget.controller,
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() {
    return Divider(
      color: Palette.divider.color,
      height: 1,
      thickness: 1,
    );
  }
}