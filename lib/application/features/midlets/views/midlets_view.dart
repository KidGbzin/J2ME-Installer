part of '../midlets_handler.dart';

class _MIDlets extends StatelessWidget {
  const _MIDlets(this.controller);

  final _Controller controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget> [
            Button(
              icon: Icons.arrow_back,
              onTap: context.pop,
            ),
          ],
        ),
      ),
      body: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return _Tile(
            controller: controller,
            jar: controller.midlets[index],
          );
        },
        itemCount: controller.midlets.length,
        padding: const EdgeInsets.all(15),
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            color: Palette.transparent.color,
            height: 15,
            thickness: 1,
          );
        },
      ),
    );
  }
}