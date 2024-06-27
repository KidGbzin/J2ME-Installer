part of '../launcher_handler.dart';

class _Landing extends StatelessWidget {
  const _Landing();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        child: Stack(
          children: <Widget> [
            Center(
              child: _text(),
            ),
            Positioned(
              bottom: 25,
              right: 15,
              child: Button(
                icon: Icons.arrow_forward_rounded,
                onTap: () {
                  context.pushReplacement('/home');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _text() {
    return Text(
      'Relive your childhood!',
      style: Typographies.header(Palette.elements).style,
      
    );
  }
}