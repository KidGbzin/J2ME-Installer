part of '../details_handler.dart';

class _Screenshot extends StatelessWidget {

  const _Screenshot(this.bytes);
  
  final Uint8List bytes;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 0.75,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Palette.divider.color,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: MemoryImage(bytes),
            filterQuality: FilterQuality.none,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}