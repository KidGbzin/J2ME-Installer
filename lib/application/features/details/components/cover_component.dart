part of '../details_handler.dart';

class _Cover extends StatelessWidget {

  const _Cover({
    required this.getCover,
  });

  final Future<File> getCover;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 0.75,
      child: FutureBuilder(
        builder: (BuildContext context, AsyncSnapshot<File> cover) {
          if (cover.hasData) {
            return _thumbnail(cover.data!);
          }
          else if (cover.hasError) {
            return const Placeholder();
          }
          else {
            return const CircularProgressIndicator();
          }
        },
        future: getCover,
      ),
    );
  }

  Widget _thumbnail(File file) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Palette.divider.color,
          width: 0,
        ),
        borderRadius: BorderRadius.circular(0),
        image: DecorationImage(
          filterQuality: FilterQuality.none,
          fit: BoxFit.contain,
          image: FileImage(file),
        ),
      ),
    );
  }
}