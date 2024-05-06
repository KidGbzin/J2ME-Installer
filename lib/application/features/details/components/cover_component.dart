part of '../details_handler.dart';

class _Cover extends StatelessWidget {
  const _Cover();

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 0.75,
      child: FutureBuilder(
        future: _Notifier.of(context)!.getThumbnail(),
        builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
          if (snapshot.hasData) {
            return Image.file(
              snapshot.data!,
              filterQuality: FilterQuality.none,
              fit: BoxFit.contain,
            );
          }
          else if (snapshot.hasError) {
            return const Placeholder();
          }
          else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}