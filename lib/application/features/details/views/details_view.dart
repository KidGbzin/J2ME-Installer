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
      final File file = await Storage.getAudio(widget.controller.game.title);
      await player.play(DeviceFileSource(file.path));
    }
    catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
          preferredSize: const Size(double.infinity, 40),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
            child: Text(
              game.title.toUpperCase(),
              style: Typographies.header(Palette.elements).style,
            ),
          ),
        ),
        title: Row(
          children: <Widget> [
            Button(
              icon: Icons.arrow_back_rounded,
              onTap: context.pop,
            ),
            const Spacer(),
            _bookmarkButton(),
            Padding(
              padding: const EdgeInsets.fromLTRB(7.5, 0, 0, 0),
              child: Button(
                icon: Icons.share_rounded,
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: <Widget> [
          _Cover(
            getCover: Storage.getCover(widget.controller.game.title),
          ),
          _divider(),
          _About(game.description ?? ''),
          _divider(),
          const _Preview(),
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

  Widget _bookmarkButton() {
    return ValueListenableBuilder(
      builder: (BuildContext context, bool isFavorite, Widget? _) {
        late IconData icon;
        if (isFavorite) {
          icon = Icons.bookmark_rounded;
        }
        else {
          icon = Icons.bookmark_outline_rounded;
        }
        return Button(
          icon: icon,
          onTap: () {
            widget.controller.bookmark();
          },
        );
      },
      valueListenable: widget.controller.isFavorite,
    );
  }
}