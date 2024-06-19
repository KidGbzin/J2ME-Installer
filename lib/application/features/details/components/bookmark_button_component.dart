part of '../details_handler.dart';

class _Bookmark extends StatelessWidget {

  const _Bookmark({
    required this.controller,
  });

  final _Controller controller;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      builder: (BuildContext context, bool isFavorite, Widget? _) {
        late final IconData icon;
        if (isFavorite) {
          icon = Icons.bookmark_rounded;
        }
        else {
          icon = Icons.bookmark_border_rounded;
        }
        return Button(
          icon: icon,
          onTap: controller.bookmark,
        );
      },
      valueListenable: controller.isFavorite,
    );
  }
}