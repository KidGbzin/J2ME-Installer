part of '../details_handler.dart';

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: Palette.divider.color,
      height: 1,
      thickness: 1,
    );
  }
}