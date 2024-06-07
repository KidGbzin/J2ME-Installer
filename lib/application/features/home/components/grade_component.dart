part of '../home_handler.dart';

class _Grade extends StatelessWidget {
  const _Grade();

  @override
  Widget build(BuildContext context) {
    int grade = Random().nextInt(5) + 1;

    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: _buildStars(grade),
    );
  }

  List<Widget> _buildStars(int grade) {
    List<Widget> temporary = <Widget> [];
    for (int index = 0; index < 5; index++) {
      temporary.add(_star());
    }
    return temporary;
  }

  Widget _star() {
    return Icon(
      Icons.star_border_rounded,
      color: Palette.grey.color,
      size: 12.5,
    );
  }
}