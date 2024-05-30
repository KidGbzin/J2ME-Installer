part of '../midlets_handler.dart';

class _Icon extends StatelessWidget {
  const _Icon(this.getIcon);

  final Future<File> getIcon;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (BuildContext context, AsyncSnapshot<File> cover) {
        if (cover.hasData) {
          return Image.file(
            cover.data!,
            filterQuality: FilterQuality.none,
            fit: BoxFit.contain,
          );
        }
        else {
          return const SizedBox.shrink();
        }
      },
      future: getIcon,
    );
  }
}