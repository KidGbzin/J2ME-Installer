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
          children: <Widget> [
            Button(
              icon: Icons.arrow_back_rounded,
              onTap: context.pop,
            ),
            const Spacer(),
            _Bookmark(
              controller: widget.controller,
            ),
          ],
        ),
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: <Widget> [
          Padding(
            padding: const EdgeInsets.all(0),
            child: _Cover(
              getCover: widget.controller.getCover(),
            ),
          ),
          _divider(),
          _About(game.description ?? ''),
          _divider(),
          FutureBuilder(
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return _Preview(
                  previews: snapshot.data!,
                );
              }
              else if (snapshot.hasError) {
                return Container(color: Colors.red);
              }
              else {
                return Container(color: Colors.transparent);
              }
            },
            future: widget.controller.getPreview(),
          ),
          _divider(),
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