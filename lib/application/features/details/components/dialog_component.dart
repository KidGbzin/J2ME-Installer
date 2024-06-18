part of '../details_handler.dart';

class _Dialog extends StatelessWidget {

  const _Dialog(this.controller);

  final _Controller controller;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Palette.background.color,
      clipBehavior: Clip.antiAlias,
      insetPadding: const EdgeInsets.all(30),
      surfaceTintColor: Palette.background.color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget> [
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
            child: Text(
              "J2ME Emulator not found!",
              style: Typographies.category(Palette.elements).style,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              "Please install the emulator from one of the links below.",
              style: Typographies.body(Palette.elements).style,
            ),
          ),
          
          _footer(),
        ],
      ),
    );
  }

  Widget _footer() {
    return IntrinsicHeight(
      child: Container(
        decoration: BoxDecoration(
          color: Palette.foreground.color,
        ),
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget> [
            Expanded(
              child: _badge(
                assetPath: 'assets/google-play-badge.png',
                onTap: controller.openPlayStore,
              ),
            ),
            VerticalDivider(
              color: Palette.divider.color,
              endIndent: 5,
              indent: 5,
              thickness: 1,
              width: 31,
            ),
            Expanded(
              child: _badge(
                assetPath: 'assets/github-badge.png',
                onTap: controller.openGitHub,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _badge({
    required String assetPath,
    required Function() onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset(
        assetPath,
        fit: BoxFit.fitWidth,
        filterQuality: FilterQuality.high,
      ),
    );
  }
}