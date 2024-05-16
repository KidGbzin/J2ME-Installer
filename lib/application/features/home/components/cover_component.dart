part of '../home_handler.dart';

class _Cover extends StatelessWidget {
  final String title;

  const _Cover(this.title);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.hasData) {
          return _coverImage(snapshot.data!);
        }
        else if (snapshot.hasError) {
          // TODO: Make a placeholder on error!
          return const Placeholder();
        }
        else {
          // TODO: Make a loading widget.
          return const SizedBox.shrink();
        }
      },
      future: _Notifier.of(context)!.loadThumbnail(title),
    );
  }

  Widget _coverImage(File file) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        boxShadow: kElevationToShadow[3],
        color: Palette.foreground.color,
        image: DecorationImage(
          fit: BoxFit.contain,
          filterQuality: FilterQuality.none,
          image: FileImage(file),
        ),
      ),
    );
  }
}