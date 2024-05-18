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
            return Image.file(
              cover.data!,
              filterQuality: FilterQuality.none,
              fit: BoxFit.contain,
            );
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
}