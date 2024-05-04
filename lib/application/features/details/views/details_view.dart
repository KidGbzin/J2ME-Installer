part of '../details_handler.dart';

class _Details extends StatelessWidget {
  final Game object;

  const _Details(this.object);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: <Widget> [
            Button(
              icon: Icons.arrow_back,
              onTap: context.pop,
            ),
          ],
        ),
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: <Widget> [
          const _Cover(),
          const _Divider(),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 15, 0, 10),
            child: Text(
            object.title.toUpperCase(),
              style: Typographies.header(Palette.elements).style,
              maxLines: 1,
              overflow: TextOverflow.clip,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: Text(
              "${object.release} • ${object.vendor}",
              style: Typographies.body(Palette.grey).style,
              textAlign: TextAlign.left,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
            child: Tags(object.tags),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
            child: Text(
              object.description ?? '',
              style: Typographies.body(Palette.grey).style,
            ),
          ),
        ],
      ),
    );
  }
}