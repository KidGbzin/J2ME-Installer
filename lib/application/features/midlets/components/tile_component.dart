part of '../midlets_handler.dart';

class _Tile extends StatelessWidget {
  const _Tile({
    required this.controller,
    required this.jar,
  });

  final _Controller controller;
  final MIDlet jar;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.5),
        color: Palette.foreground.color,
      ),
      width: double.infinity,
      child: Column(
        children: <Widget> [
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: _header(),
          ),
          _divider(),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 12.5, 15, 15),
            child: _body(),
          ),
          _divider(),
        ],
      ),
    );
  }

  Widget _divider() {
    return Divider(
      color: Palette.divider.color,
      height: 1,
      thickness: 1,
    );
  }

  Widget _header() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget> [
        Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
          ),
          height: 25,
          width: 25,
          child: _Icon(Storage.getIcon(jar.title)),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 15, 15, 15),
          child: Text(
            jar.title,
            maxLines: 1,
            style: Typographies.tile(Palette.elements).style,
          ),
        ),
      ],
    );
  }

  Widget _body() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: <Widget> [
        RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: 'Resolution:  ',
                style: Typographies.tile(Palette.elements).style,
              ),
              TextSpan(
                text: '${jar.resolution.replaceAll('x', ' x ')}\n',
                style: Typographies.body(Palette.grey).style,
              ),
              TextSpan(
                text: 'Size:  ',
                style: Typographies.tile(Palette.elements).style,
              ),
              TextSpan(
                text: '${jar.size} KB\n',
                style: Typographies.body(Palette.grey).style,
              ),
              TextSpan(
                text: 'Version:  ',
                style: Typographies.tile(Palette.elements).style,
              ),
              TextSpan(
                text: jar.version,
                style: Typographies.body(Palette.grey).style,
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            decoration: BoxDecoration(
              color: Palette.transparent.color,
              image: DecorationImage(
                image: AssetImage('assets/brands/${jar.brand.replaceAll(' ', '-')}.png'),
                fit: BoxFit.contain,
                alignment: Alignment.center,
              ),
            ),
            height: 60,
            width: 125,
          ),
        ),
      ],
    );
  }
}