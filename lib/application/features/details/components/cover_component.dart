part of '../details_handler.dart';

class _Cover extends StatelessWidget {
  const _Cover();

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 0.75,
      child: Container(
        decoration: BoxDecoration(
          color: Palette.background.color,
          image: _getCoverImage(context),
        ),
      ),
    );
  }

  DecorationImage _getCoverImage(BuildContext context) {
    final Uint8List? thumbnail = _Notifier.of(context)!.getThumbnail();
    if (thumbnail == null) {
      return const DecorationImage(
        fit: BoxFit.cover,
        image: AssetImage('assets/java-logo.png'),
      );
    }
    else {
      return DecorationImage(
        fit: BoxFit.cover,
        filterQuality: FilterQuality.none,
        image: MemoryImage(thumbnail),
      );
    }
  }
}