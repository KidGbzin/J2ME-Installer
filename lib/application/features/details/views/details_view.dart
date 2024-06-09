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
      body: ListView(
        padding: EdgeInsets.zero,
        children: <Widget> [
          _Cover(
            getCover: Storage.getCover(widget.controller.game.title),
          ),

          

          const _Divider(),

          ActionBar(game.title),

          const Padding(
            padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
            child: StatusBar(),
          ),

          const _Divider(),

          Padding(
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
            child: Row(
              children: <Widget> [
                _PlayButton(widget.controller),
              ],
            ),
          ),

          const _Divider(),

          Padding(
            padding: const EdgeInsets.fromLTRB(15, 25, 15, 15),
            child: Text(
              "About".toUpperCase(),
              style: Typographies.tile(Palette.elements).style,
            ),
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
            padding: const EdgeInsets.fromLTRB(15, 25, 15, 15),
            child: Text(
              'Screenshots'.toUpperCase(),
              style: Typographies.tile(Palette.elements).style,
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

class StatusBar extends StatelessWidget {
  const StatusBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Palette.foreground.color,
      ),
      height: 45,
      width: double.infinity,
    );
  }
}

class ActionBar extends StatelessWidget {
  const ActionBar(this.a, {super.key});

  final String a;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Palette.transparent.color,
      ),
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
      width: double.infinity,
      child: Row(
        children: <Widget> [
          Button(
            icon: Icons.arrow_back,
            onTap: context.pop,
          ),
          Expanded(
            child: Center(
              child: Text(
              a.toUpperCase(),
              style: Typographies.header(Palette.elements).style,
                        ),
            )),
          Button(icon: Icons.favorite_border_rounded, onTap: () {}),
        ],
      ),
    );
  }


  Widget _divider() {
    return VerticalDivider(
      color: Palette.divider.color,
      thickness: 1,
      width: 1,
    );
  }

  Widget _downloads() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget> [
        Icon(
          Icons.download_rounded,
          color: Palette.elements.color,
        ),
        VerticalDivider(
          color: Palette.transparent.color,
          width: 7.5,
        ),
        Text(
          '259',
          style: Typographies.body(Palette.elements).style,
        )
      ],
    );
  }

  Widget _release() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget> [
        Icon(
          Icons.event_rounded,
          color: Palette.elements.color,
        ),
        VerticalDivider(
          color: Palette.transparent.color,
          width: 7.5,
        ),
        Text(
          '2010',
          style: Typographies.body(Palette.elements).style,
        )
      ],
    );
  }
  

  Widget _grade() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget> [
        const Icon(
          Icons.grade_rounded,
          color: Color.fromARGB(255, 255, 213, 26),
        ),
        VerticalDivider(
          color: Palette.transparent.color,
          width: 7.5,
        ),
        Text(
          '4.0',
          style: Typographies.body(Palette.elements).style,
        )
      ],
    );
  }
}

class _Screenshots extends StatelessWidget {
  const _Screenshots();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        children: <Widget> [
          Expanded(child: _image()),
          _divider(),
          Expanded(child: _image()),
          _divider(),
          Expanded(child: _image()),
        ],
      ),
    );
  }

  Widget _divider() {
    return SizedBox.square(
      dimension: 15,
      child: Icon(
        Icons.circle,
        color: Palette.divider.color,
        size: 5,
      ),
    );
  }

  Widget _image() {
    return AspectRatio(
      aspectRatio: 0.75,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          border: Border.all(
            color: Palette.divider.color,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
          image: const DecorationImage(
            image: AssetImage('assets/a.png'),
          ),
        ),
      ),
    );
  }
}