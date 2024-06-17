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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Palette.transparent.color,
        surfaceTintColor: Palette.transparent.color,
        shape: const Border(),
        title: Row(
          children: <Widget> [
            Button.shadow(
              icon: Icons.arrow_back_ios_rounded,
              onTap: context.pop,
            ),
            const Spacer(),
            Button.shadow(
              icon: Icons.favorite_border_rounded,
              onTap: () {},
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(7.5, 0, 0, 0),
              child: Button.shadow(
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
          const _Divider(),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 25, 15, 15),
            child: Text(
              game.title.toUpperCase().replaceAll(':', ' -'),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Typographies.header(Palette.elements).style,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 25),
            child: Text(
              '${game.release} • ${game.vendor}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Typographies.body(Palette.grey).style,
            ),
          ),
          const _Divider(),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 25, 15, 15),
            child: Text(
              "About".toUpperCase(),
              style: Typographies.category(Palette.elements).style,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 25),
            child: Text(
              game.description ?? '',
              style: Typographies.body(Palette.grey).style,
            ),
          ),

          const _Divider(),

          Padding(
            padding: const EdgeInsets.fromLTRB(15, 25, 15, 15),
            child: Text(
              'Preview'.toUpperCase(),
              style: Typographies.category(Palette.elements).style,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: Text(
              "The game's characteristics and screenshots may vary according to the model of your phone.",
              style: Typographies.body(Palette.grey).style,
            ),
          ),
          const _Screenshots(),
        ],
      ),
    );
  }
}