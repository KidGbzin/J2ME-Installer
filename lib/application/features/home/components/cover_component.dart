part of '../home_handler.dart';

class _Cover extends StatelessWidget {
  final Future<File>? getCover;

  const _Cover(this.getCover);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (BuildContext context, AsyncSnapshot<File> cover) {
        if (cover.hasData) {
          return _coverImage(cover.data!);
        }
        else if (cover.hasError) {
          // TODO: Make a placeholder on error!
          return const Placeholder();
        }
        else {
          // TODO: Make a loading widget.
          return const SizedBox.shrink();
        }
      },
      future: getCover,
    );
  }

  Widget _coverImage(File file) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7.5),
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